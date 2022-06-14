import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/style/colors.dart';
import '../../../../shared/utils/analytics_helper.dart';
import '../../../../shared/widgets/custom_app_bar_widget.dart';
import '../../../../shared/widgets/custom_button_widget.dart';
import '../../../../shared/widgets/custom_text_field_widget.dart';
import '../../cubits/sign_up/sign_up_cubit.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class SignUpPage extends StatefulWidget {
  final Function callBack;
  final bool isOriginHome;

  const SignUpPage({Key key, this.callBack, this.isOriginHome = true})
      : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _email$ = TextEditingController();
  final _password$ = TextEditingController();
  final _confirmPassword$ = TextEditingController();

  final _signUpCubit = Modular.get<SignUpCubit>();
  final _formKey = GlobalKey<FormState>();

  void _handleState(SignUpState state) {
    state.maybeWhen(
      loadSuccess: () {
        AnalyticsHelper.registerSignUpByEmailPassword();
        if (widget.isOriginHome) {
          Navigator.of(context).popAndPushNamed(
            "/home",
          );
        } else {
          Navigator.of(context)
            ..pop()
            ..pop();

          widget.callBack.call();
        }
      },
      loadFailure: (message) {
        Flushbar(
          message: message,
          duration: Duration(seconds: 2),
          animationDuration: Duration(seconds: 2),
        ).show(context);
      },
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsHelper.setSignUpPage();
    return Scaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(
        bloc: _signUpCubit,
        listener: (_, state) => _handleState(state),
        builder: (_, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomAppBarWidget(
                  title: "Register to Motorly",
                ),
                SafeArea(
                  child: _buildContent(state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(SignUpState state) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
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
              hintText: "Password*",
              obscureText: true,
              keyboardType: TextInputType.text,
              onValidator: (text) {
                if (text.isEmpty) {
                  return "Field Empty";
                }
                return null;
              },
            ),
            SizedBox(
              height: 7,
            ),
            RichText(
                text: TextSpan(
                    text: '(at least 6 characters)',
                    style: TextStyle(
                      color: Theme.of(context).hoverColor,
                      fontSize: 12,
                    ))),
            SizedBox(height: 20),
            CustomTextFieldWidget(
              controller: _confirmPassword$,
              hintText: "Confirm Password*",
              obscureText: true,
              onValidator: (text) {
                if (text != _password$.text || text.isEmpty) {
                  return "Field is not equal";
                }
                return null;
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 33),
            CustomButtonWidget(
              text: "Register",
              isLoading: state == SignUpState.loadLoading(),
              onTap: () {
                if (_formKey.currentState.validate()) {
                  _signUpCubit.load(
                    email: _email$.text,
                    password: _password$.text,
                    name: _email$.text.split("@").first,
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By registering you agree to ',
                  style: TextStyle(
                    color: Theme.of(context).hoverColor,
                    fontSize: 14,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch("https://motorly.nz/terms-and-conditions");
                        },
                      text: 'Terms & Conditions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(text: "\nand "),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch("https://motorly.nz/privacy-policy");
                        },
                      text: 'Privacy Policy',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(text: " of the Motorly"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
