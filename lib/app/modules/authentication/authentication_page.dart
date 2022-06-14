import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/style/app_dimensions.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/text_styles.dart';
import '../../shared/utils/analytics_helper.dart';
import '../../shared/widgets/custom_app_bar_widget.dart';
import '../../shared/widgets/custom_button_widget.dart';
import '../../shared/widgets/custom_text_field_widget.dart';
import '../home/widgets/head_widget.dart';
import 'cubits/sign_in/sign_in_cubit.dart';
import 'pages/sign_up/sign_up_page.dart';
import 'widgets/login_button_widget.dart';

class AuthenticationPage extends StatefulWidget {
  final Function callBack;
  final bool isOriginHome;

  const AuthenticationPage({Key key, this.callBack, this.isOriginHome = true})
      : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _email$ = TextEditingController();
  final _password$ = TextEditingController();

  final _signInCubit = Modular.get<SignInCubit>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AnalyticsHelper.setLogInPage();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          CustomAppBarWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: BlocConsumer<SignInCubit, SignInState>(
                bloc: _signInCubit,
                listener: (_, state) {
                  state.maybeWhen(
                    loadSuccess: () {
                      AnalyticsHelper.registerLogInByEmailPassword();
                      // Timer(Duration(seconds: 2), () {
                      //   Flushbar(
                      //     message: 'You have successfully logged in!',
                      //     duration: Duration(seconds: 2),
                      //     backgroundColor: AppColors.success,
                      //     animationDuration: Duration(seconds: 2),
                      //   ).show(context);
                      // });

                      // Navigator.pushNamedAndRemoveUntil(
                      //   context,
                      //   "/home",
                      //   (route) => false,
                      // );
                      Navigator.of(context).maybePop();
                      widget.callBack?.call();
                    },
                    loadFailure: (message) {
                      Flushbar(
                        message: message,
                        duration: Duration(seconds: 2),
                        backgroundColor: AppColors.danger,
                        animationDuration: Duration(seconds: 2),
                      ).show(context);
                    },
                    orElse: () {},
                  );
                },
                builder: (_, state) {
                  //final size = MediaQuery.of(context).size.width;
                  return Container(
                    padding: AppDimensions.marginScreen,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          HeadWidget(),
                          SizedBox(height: 42),
                          if (Platform.isIOS)
                            LoginButtonWidget(
                              svgIcon: "assets/icon/icon-apple.svg",
                              color: Colors.white,
                              textColor: Colors.black,
                              onTap: _signInCubit.loadWithApple,
                              text: 'Continue with Apple ID',
                            ),
                          if (Platform.isIOS) SizedBox(height: 7),
                          LoginButtonWidget(
                            svgIcon: "assets/icon/icon-facebook.svg",
                            color: Colors.white,
                            textColor: Colors.black,
                            onTap: _signInCubit.loadWithFacebook,
                            text: 'Continue with Facebook',
                          ),
                          SizedBox(height: 7),
                          LoginButtonWidget(
                            svgIcon: "assets/icon/icon-google.svg",
                            color: Colors.white,
                            textColor: Colors.black,
                            onTap: _signInCubit.loadWithGoogle,
                            text: 'Continue with Google',
                          ),
                          SizedBox(height: 23),
                          CustomTextFieldWidget(
                            controller: _email$,
                            hintText: "E-mail",
                            onValidator: (text) {
                              if (!text.isValidEmail()) {
                                return "Invalid email";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20),
                          CustomTextFieldWidget(
                            controller: _password$,
                            hintText: "Password",
                            obscureText: true,
                            onValidator: (text) {
                              if (text.length < 6) {
                                return "Invalid password";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              AnalyticsHelper.registerPasswordReset();
                              Navigator.of(context).pushNamed(
                                "/authentication/reset-password",
                              );
                            },
                            child: Text(
                              "Forget password?",
                              style: AppTextStyles.primaryPBold.copyWith(
                                color: AppColors.primary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          CustomButtonWidget(
                            text: "Login",
                            isLoading: state == SignInState.loadLoading(),
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _signInCubit.load(
                                  email: _email$.text,
                                  password: _password$.text,
                                );
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Don\'t have an account?',
                                style: TextStyle(
                                  color: Theme.of(context).hoverColor,
                                  fontSize: 12,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        AnalyticsHelper.registerBeginSignUp();
                                        Navigator.of(context)
                                            .push(MaterialPageRoute<void>(
                                          builder: (context) => SignUpPage(
                                              isOriginHome: widget.isOriginHome,
                                              callBack: widget.callBack),
                                        ));
                                      },
                                    text: ' Register now',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 45),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* Use if we couldn't get approvation using custom login button.
Widget _buildAppleLoginButton(BuildContext context, signInCubit) {
  return FutureBuilder(
    future: AppleSignIn.isAvailable(),
    builder: (context, snapshot) {
      if (snapshot.data == true) {
        return AppleSignInButton(
          onPressed: () async {
            // ignore: unnecessary_statements
            signInCubit.loadWithApple;
          },
        );
      } else {
        return Container();
      }
    },
  );
}
*/
