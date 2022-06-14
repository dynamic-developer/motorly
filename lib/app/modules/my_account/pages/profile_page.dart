import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/text_styles.dart';
import '../../../shared/widgets/custom_app_bar_widget.dart';
import '../../../shared/widgets/custom_outlined_button_widget.dart';
import '../../../shared/widgets/permission_required_widget.dart';
import '../../home/cubits/sign_out/sign_out_cubit.dart';
import '../../home/cubits/user/user_cubit.dart';
import '../../home/widgets/item_card_widget.dart';
import '../../home/widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _signOutCubit = Modular.get<SignOutCubit>();

  final _userCubit = Modular.get<UserCubit>();

  @override
  Widget build(BuildContext context) {
    _userCubit.load();
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarWidget(
            title: "Profile",
          ),
          Expanded(
            child: BlocBuilder<UserCubit, UserState>(
              bloc: _userCubit,
              builder: (_, state) {
                return state.maybeWhen(
                  loadLoaded: (user) => _buildProfile(
                    context,
                    user: user,
                  ),
                  loadLoading: () => CircularProgressIndicator(),
                  orElse: () =>
                      PermissionRequiredWidget(currentContext: context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfile(context, {User user}) {
    return SingleChildScrollView(
      padding: AppDimensions.marginScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileWidget(
            fullName: "${user?.displayName}",
            urlImage: user?.photoURL,
          ),
          ItemCardWidget(
            title: "Personal Information",
            onTap: () {
              Navigator.of(context).pushNamed(
                "/my-account/details",
                arguments: user,
              );
            },
          ),
          AppDimensions.sizedSpace,
          Text(
            "Settings",
            style: AppTextStyles.primaryH1Medium.copyWith(
              fontSize: 12,
              color: Theme.of(context).hoverColor,
            ),
          ),
          // AppDimensions.sizedSpace,
          // // ItemCardWidget(
          // //   title: "Security",
          // //   onTap: () {},
          // // ),
          AppDimensions.sizedSpace,
          ItemCardWidget(
            title: "Help and support",
            onTap: () {
              launch('mailto:hello@skadi.co.nz');
            },
          ),
          // AppDimensions.sizedSpace,
          // ItemCardWidget(
          //   title: "Logaly",
          //   onTap: () {},
          // ),
          AppDimensions.sizedSpace,
          _buildLogOut(context),
          AppDimensions.sizedSpace,
        ],
      ),
    );
  }

  Widget _buildLogOut(context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listener: (_, state) {
        state.maybeWhen(
          loadSuccess: () {
            // Timer(Duration(seconds: 2), () {

            // });
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   "/dashboard",
            //   (route) => false,
            // );
            //Navigator.of(context).maybePop();
            setState(() {});
          },
          orElse: () {},
        );
      },
      bloc: _signOutCubit,
      child: CustomOutlinedButtonWidget(
        onTap: _signOutCubit.load,
        title: "Sign Out",
      ),
    );
  }
}
