import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/style/app_dimensions.dart';
import '../../../../shared/utils/analytics_helper.dart';
import '../../../../shared/widgets/custom_app_bar_widget.dart';
import '../../../../shared/widgets/custom_button_widget.dart';
import '../../../../shared/widgets/custom_text_field_widget.dart';
import '../../cubits/reset_password/reset_password_cubit.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _email$ = TextEditingController();

  final _resetPasswordCubit = Modular.get<ResetPasswordCubit>();
  final _formKey = GlobalKey<FormState>();

  void _handleState(ResetPasswordState state) {
    state.maybeWhen(
      loadSuccess: () {
        Navigator.of(context).pushNamed(
          "authentication/reset-finish",
        );
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
    AnalyticsHelper.setResetPasswordPage();
    return Scaffold(
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        bloc: _resetPasswordCubit,
        listener: (_, state) => _handleState(state),
        builder: (_, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomAppBarWidget(
                title: "Forget Password",
              ),
              Padding(
                padding: const EdgeInsets.all(26.0),
                child: Text(
                  "Please enter your registered email to "
                  "reset your password.",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: _buildContent(state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(ResetPasswordState state) {
    return SingleChildScrollView(
      padding: AppDimensions.marginScreen,
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
            SizedBox(height: 40),
            CustomButtonWidget(
              text: "Recover Password",
              isLoading: state == ResetPasswordState.loadLoading(),
              onTap: () {
                if (_formKey.currentState.validate()) {
                  _resetPasswordCubit.load(
                    email: _email$.text,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
