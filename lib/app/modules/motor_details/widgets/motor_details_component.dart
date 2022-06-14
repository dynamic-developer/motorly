import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/style/app_dimensions.dart';
import '../../../shared/utils/analytics_helper.dart';
import '../../home/models/filter_model.dart';
import '../../home/models/models.dart';
import '../cubits/offers/offers_cubit.dart';
import 'motor_detail_widget.dart';
import 'offers_widget.dart';
import 'price_details_widget.dart';

class MotorDetailsComponent extends StatefulWidget {
  final MotorModel motor;
  final ScrollController scrollController;

  MotorDetailsComponent({
    @required this.motor,
    @required this.scrollController,
  });

  @override
  _MotorDetailsComponentState createState() => _MotorDetailsComponentState();
}

class _MotorDetailsComponentState extends State<MotorDetailsComponent> {
  final _offersCubit = Modular.get<OffersCubit>();

  @override
  void initState() {
    super.initState();
    _offersCubit.load(
      FilterOfferModel(
          model: widget.motor.model,
          make: widget.motor.make,
          year: widget.motor.year,
          yearMax: widget.motor.year,
          page: 1,
          sortOrder: "price asc"),
    );
  }

  String get url =>
      'https://www.facebook.com/marketplace/search/?query=${widget.motor.make}%20${widget.motor.model}%20${widget.motor.year}';

  @override
  Widget build(BuildContext context) {
    AnalyticsHelper.setCarDetailsPage();

    return Padding(
      padding: AppDimensions.marginWidget,
      child: Stack(
        children: [
          Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(13),
                  child: MotorDetailWidget(
                    motor: widget.motor,
                  ),
                ),
              ),
              if (widget.motor.price != null)
                Card(
                  child: Padding(
                    padding: AppDimensions.marginWidget,
                    child: Column(
                      children: [
                        PriceDetailsWidget(widget.motor.price),
                      ],
                    ),
                  ),
                ),
              // SizedBox(height: 20),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Divider(
              //         color: Colors.white,
              //       ),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Text(
              //       " Offers",
              //       style: AppTextStyles.primaryH1Light.copyWith(
              //         color: Colors.white,
              //         fontSize: 16,
              //       ),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Expanded(
              //       child: Divider(
              //         color: Colors.white,
              //       ),
              //     ),
              //   ],
              // ),
              OffersWidget(
                motor: widget.motor,
                url: url,
                scrollController: widget.scrollController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
