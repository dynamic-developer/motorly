import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/widgets/custom_app_bar_widget.dart';
import '../../../shared/widgets/custom_button_widget.dart';
import '../../../shared/widgets/custom_text_field_widget.dart';
import '../cubit/edit_user/edit_user_cubit.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final User user = Modular.args.data;

  final _editUserCubit = Modular.get<EditUserCubit>();

  final _username$ = TextEditingController();
  final _email$ = TextEditingController();
  // final _gender$ = TextEditingController();
  // final _age$ = TextEditingController();
  // final _streetAddress$ = TextEditingController();
  // final _city$ = TextEditingController();
  // final _zipCode$ = TextEditingController();
  // final _citizenship$ = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _username$.text = user.displayName;
    _email$.text = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomAppBarWidget(
            title: "Personal Information",
          ),
          Expanded(
            child: _buildForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: AppDimensions.marginScreen,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFieldWidget(
              controller: _username$,
              hintText: "Username",
              onValidator: (text) {
                if (text.length < 4) {
                  return "Short name";
                }
                return null;
              },
            ),
            AppDimensions.sizedSpace,
            CustomTextFieldWidget(
              controller: _email$,
              hintText: "E-mail",
              disable: true,
              onValidator: (text) {
                if (!text.isValidEmail()) {
                  return "Invalid email";
                }
              },
            ),
            AppDimensions.sizedSpace,
            // CustomTextFieldWidget(
            //   controller: _gender$,
            //   hintText: "Gender",
            // ),
            // AppDimensions.sizedSpace,
            // CustomTextFieldWidget(
            //   controller: _age$,
            //   hintText: "Age",
            // ),
            // AppDimensions.sizedSpace,
            // CustomTextFieldWidget(
            //   controller: _streetAddress$,
            //   hintText: "Street Address",
            // ),
            // AppDimensions.sizedSpace,
            // CustomTextFieldWidget(
            //   controller: _city$,
            //   hintText: "City",
            // ),
            // AppDimensions.sizedSpace,
            // CustomTextFieldWidget(
            //   controller: _zipCode$,
            //   hintText: "Zip/AREA Code",
            // ),
            // AppDimensions.sizedSpace,
            // CustomTextFieldWidget(
            //   controller: _citizenship$,
            //   hintText: "Citizenship",
            // ),
            BlocConsumer<EditUserCubit, EditUserState>(
              bloc: _editUserCubit,
              listener: (_, state) {
                state.maybeWhen(
                  loadUpdated: () {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      message: "Updated",
                      backgroundColor: AppColors.success,
                    ).show(context);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/home', (route) => false);
                  },
                  loadFailure: (text) {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      message: text,
                      backgroundColor: AppColors.danger,
                    ).show(context);
                  },
                  orElse: () {},
                );
              },
              builder: (_, state) {
                return CustomButtonWidget(
                  text: "Submit",
                  isLoading: state == EditUserState.loadLoading(),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      if (_email$.text != user.email ||
                          _username$.text != user.displayName) {
                        _editUserCubit.edit(
                          email: _email$.text,
                          username: _username$.text,
                        );
                      } else {
                        Flushbar(
                          duration: Duration(seconds: 3),
                          message: "Don't have any change",
                          backgroundColor: AppColors.danger,
                        ).show(context);
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
