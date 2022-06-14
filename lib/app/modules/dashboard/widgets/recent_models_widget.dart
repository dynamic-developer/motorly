import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/shared/utils/analytics_helper.dart';

import '../../../shared/services/firestore_service.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../home/models/models.dart';
import '../cubits/recent_models/recent_models_cubit.dart';
import '../pages/recent_motors_page.dart';
import 'recent_model_widget.dart';

class RecentModelsWidget extends StatelessWidget {
  final firestoreService = Modular.get<FirestoreService>();

  final _historyCubit = Modular.get<RecentModelsCubit>();

  final authInstance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentModelsCubit, RecentModelsState>(
      bloc: _historyCubit,
      builder: (context, state) {
        if (state is RecentModelsFailure) {
          return Container();
        }

        if (state is RecentModelsLoaded) {
          if (state.data == [] || state.data.isEmpty || state.data == null) {
            return Container();
          }
          return _buildLoaded(state.data);
        }
        return _buildProgressIndicator();
      },
    );
  }

  Widget _buildLoaded(List<MotorModel> models) {
    return Builder(
      builder: (context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: _buildHead(models, context),
            ),
            SizedBox(height: 20),
            _buildOptions(models),
          ],
        ),
      ),
    );
  }

  // Widget _buildError(String message) {
  //   return Container(
  //     height: 200,
  //     decoration: BoxDecoration(
  //       borderRadius: AppDimensions.borderRadius,
  //       color: AppColors.backgroundCard.withOpacity(0.4),
  //     ),
  //     child: Center(
  //       child: Text("Something went wrong: $message"),
  //     ),
  //   );
  // }

  Widget _buildProgressIndicator() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  // Widget _buildNoData(context) {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 33, right: 33),
  //       child: Container(
  //         alignment: Alignment.center,
  //         decoration: BoxDecoration(
  //           borderRadius: AppDimensions.borderRadius,
  //           color: AppColors.backgroundCard.withOpacity(0.4),
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(top: 23.0),
  //               child: Text(
  //                 "Last Scans",
  //                 style: AppTextStyles.primaryBold.copyWith(
  //                   color: Colors.white,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 15),
  //             Text(
  //               "Sorry, there are no recent models. Click\n"
  //               "the button below and start the search :).",
  //               style: TextStyle(
  //                 fontSize: 12,
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             Container(
  //               height: 50,
  //               child: CustomButtonWidget(
  //                 text: "Get Started",
  //                 onTap: () {
  //                   _navigationCubit.emit(1);
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildOptions(List<MotorModel> data) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 30, left: 30, bottom: 30),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          data.length,
          (index) => RecentModelWidget(motor: data[index]),
        ),
      ),
    );
  }

  Widget _buildHead(List<MotorModel> data, context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Last Scans",
                    style: AppTextStyles.primaryBold.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                AnalyticsHelper.tappedLastScans();
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (context) => RecentMotorsPage(data)),
                );
              },
              child: Row(
                children: [
                  Text(
                    "More",
                    style: AppTextStyles.primaryH0Bold.copyWith(
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                  ),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: AppColors.primary,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
