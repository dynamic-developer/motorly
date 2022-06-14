import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/utils/analytics_helper.dart';
import '../../shared/widgets/custom_fullscreen_loader_widget.dart';
import '../../shared/widgets/dynamic_loading_widget.dart';
import '../home/cubits/loader/loader.cubut.dart';
import 'cubits/motor/motor_cubit.dart';
import 'widgets/app_bar_widget.dart';
import 'widgets/failure_widget.dart';
import 'widgets/motor_details_component.dart';

class MotorDetailsPage extends StatefulWidget {
  final String plate;
  MotorDetailsPage({@required this.plate});

  @override
  _MotorDetailsPageState createState() => _MotorDetailsPageState();
}

class _MotorDetailsPageState extends State<MotorDetailsPage> {
  final _motorsCubit = Modular.get<MotorCubit>();
  final _loaderCubit = Modular.get<LoaderCubit>();
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _motorsCubit.load(widget.plate);
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsHelper.setCarDetailsPage();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0, left: 13),
                    child: AppBarWidget(),
                  ),
                  BlocBuilder<MotorCubit, MotorState>(
                    bloc: _motorsCubit,
                    builder: (context, state) {
                      return state.maybeWhen(
                        loadLoaded: (item) => MotorDetailsComponent(
                          motor: item,
                          scrollController: _scrollController,
                        ),
                        loadLoading: () =>
                            Center(child: DynamicLoadingWidget()),
                        loadFailure: (message) => FailureWidget(message),
                        orElse: () => Container(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          BlocConsumer<LoaderCubit, bool>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) => print(state),
              bloc: _loaderCubit,
              builder: (context, state) {
                if (state) {
                  return CustomFullscreenLoaderWidget();
                }
                return Container();
              }),
        ],
      ),
    );
  }

  // Widget _buildLoading() {
  //   return Shimmer.fromColors(
  //     baseColor: AppColors.gray70,
  //     highlightColor: AppColors.backgroundWidget,
  //     enabled: true,
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           SizedBox(height: 20),
  //           Container(
  //             width: double.maxFinite,
  //             height: 125,
  //             margin: EdgeInsets.symmetric(horizontal: 20),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(5),
  //               color: Theme.of(context).cardColor,
  //             ),
  //           ),
  //           Container(
  //             width: double.maxFinite,
  //             height: 91,
  //             margin: EdgeInsets.all(20).copyWith(bottom: 0),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(5),
  //               color: Theme.of(context).cardColor,
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //             child: ShimmerOffersWidget(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
