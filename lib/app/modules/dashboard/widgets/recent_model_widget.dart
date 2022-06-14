import 'package:flutter/material.dart';

import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../home/models/old_motor_model.dart';
import '../../motor_details/motor_details_module.dart';
import 'recent_body_type_widget.dart';

class RecentModelWidget extends StatelessWidget {
  final MotorModel motor;
  RecentModelWidget({@required this.motor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width * .65,
      child: Card(
        child: InkWell(
          onTap: () async {
            Navigator.of(context).pushNamed(
              MotorDetailsModule.route,
              arguments: motor.plate.toString(),
            );
          },
          child: _buildContent(context, motor),
        ),
      ),
    );
  }

  Widget _buildContent(context, MotorModel motor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppDimensions.borderRadius,
      ),
      height: 70,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RecentBodyTypeWidget(bodyType: motor.bodyType),
          SizedBox(
            width: 7,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '${motor?.make} ${motor?.model} ${motor?.year} ',
                    style: AppTextStyles.primaryRecentMotorBold.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Engine Size: ${motor?.engineSize}cc | Fuel Type: (${motor?.fuelType})',
                    style: AppTextStyles.primaryRecentMotor.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
