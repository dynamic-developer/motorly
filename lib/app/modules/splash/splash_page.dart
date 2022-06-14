import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

import '../../shared/style/colors.dart';
import '../../shared/utils/analytics_helper.dart';
import 'cubits/authentication_state/authentication_state_cubit.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authenticationCubit = Modular.get<AuthenticationStateCubit>();

  @override
  void initState() {
    super.initState();
    AnalyticsHelper.registerOpenApp();
    _authenticationCubit.verify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray90,
      body: BlocListener<AuthenticationStateCubit, AuthenticationState>(
        bloc: _authenticationCubit,
        listener: (_, state) {
          Timer(Duration(seconds: 1), () {
            state.maybeWhen(
              orElse: () {
                Navigator.of(context).pushReplacementNamed("/home/");
              },
              loadUnauthenticated: () {
                _authenticationCubit.checkFirstOpen(context);
              },
            );
          });
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.9,
                child: Lottie.asset('assets/splash.json'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
