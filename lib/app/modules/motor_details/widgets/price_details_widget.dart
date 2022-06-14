import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../shared/style/text_styles.dart';
import '../../home/models/models.dart';

class PriceDetailsWidget extends StatelessWidget {
  final PriceModel _price;
  PriceDetailsWidget(this._price);

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat.decimalPattern("en_NZ");
    return Column(children: [
      Container(
        constraints: const BoxConstraints(maxHeight: 90),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimelineTile(
              beforeLineStyle: LineStyle(thickness: 1),
              afterLineStyle: LineStyle(thickness: 1),
              indicatorStyle: IndicatorStyle(
                color: Theme.of(context).canvasColor,
                width: 7,
                height: 7,
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              lineXY: 0.3,
              isFirst: true,
              startChild: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '\$ ${formatter.format(_price?.stats?.min)}',
                    style: AppTextStyles.primaryH1Medium.copyWith(
                      color: Theme.of(context).canvasColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
              endChild: Column(
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Lowest',
                    style: AppTextStyles.primaryMinLimitsNormal,
                  ),
                ],
              ),
            ),
            Expanded(
              child: TimelineTile(
                beforeLineStyle: LineStyle(thickness: 1),
                afterLineStyle: LineStyle(thickness: 1),
                indicatorStyle: IndicatorStyle(
                  color: Theme.of(context).canvasColor,
                  width: 10,
                  height: 10,
                ),
                axis: TimelineAxis.horizontal,
                alignment: TimelineAlign.center,
                lineXY: 0.3,
                hasIndicator: true,
                startChild: Column(
                  children: [
                    Text(
                      '\$ ${formatter.format(_price?.stats?.average)}',
                      style: AppTextStyles.primaryPriceAverageBold.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                endChild: Column(
                  children: [
                    SizedBox(height: 8),
                    Text(
                      'Average Price',
                      style: AppTextStyles.primaryAverageNormal.copyWith(
                        color: Theme.of(context).canvasColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TimelineTile(
              beforeLineStyle: LineStyle(thickness: 1),
              afterLineStyle: LineStyle(thickness: 1),
              indicatorStyle: IndicatorStyle(
                color: Theme.of(context).canvasColor,
                width: 7,
                height: 7,
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              lineXY: 0.3,
              isLast: true,
              startChild: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '\$ ${formatter.format(_price?.stats?.max)}',
                    style: AppTextStyles.primaryH1Medium.copyWith(
                      color: Theme.of(context).canvasColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
              endChild: Column(
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Highest',
                    style: AppTextStyles.primaryMaxLimitsNormal,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        child:
            Text("based on ${_price.stats.count} listings in the last 6 months",
                style: AppTextStyles.primaryH1Medium.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                )),
      )
    ]);
  }
}
