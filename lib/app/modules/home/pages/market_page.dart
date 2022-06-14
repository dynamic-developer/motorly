import 'package:flutter/material.dart';

import '../../../shared/style/app_dimensions.dart';
import '../../../shared/utils/analytics_helper.dart';
import '../widgets/choose_plate_widget.dart';

class MarketPage extends StatelessWidget {
  //final _motorCubit = Modular.get<MotorCubit>();

  @override
  Widget build(BuildContext context) {
    AnalyticsHelper.setMarketPage();

    return Padding(
      padding: AppDimensions.marginScreen,
      child: Center(child: ChoosePlateWidget()),
    );
  }
}
