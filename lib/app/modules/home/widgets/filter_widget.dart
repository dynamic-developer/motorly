import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motorly/app/shared/repositories/database_repository.dart';
import '../../../shared/database/database_provider.dart';

import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../components/filters_component.dart';
import '../models/filter_model.dart';

class FilterWidget extends StatelessWidget {
  final ValueChanged<FilterOfferModel> onFilter;
  final bool isActived;
  final int highestPrice;
  final int lowestPrice;
  final List<Make> makes;
  final List<Model> models;
  final FilterOfferModel currentFilter;
  final FilterOfferModel baseFilter;
  final List<String> years;
  final String location;

  FilterWidget({
    this.onFilter,
    this.highestPrice,
    this.lowestPrice,
    this.makes,
    this.models,
    this.location,
    this.currentFilter,
    this.years,
    this.isActived = false,
    this.baseFilter,
  });

  @override
  Widget build(BuildContext context) {
    return _buildOutlined(
      color: isActived ? AppColors.primary : null,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/ilustrations/filter.svg',
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            color: AppColors.backgroundCard,
            height: 40,
            width: 1,
          ),
          Expanded(
            child: Center(
              child: Text(
                "Filter",
                style: TextStyle(fontSize: 13.0, fontFamily: 'OpenSans'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutlined({
    Widget child,
    Color color,
  }) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          print(
              "MAKE TEST Filter_widget.DART ---> onTap -->_buildOutlined :: ${currentFilter.make}");

          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (_) => FilterComponent(
              onFilter,
              highestPrice: highestPrice,
              years: years,
              currentFilter: currentFilter,
              lowestPrice: lowestPrice,
              makes: makes,
              models: models,
              location: location,
              baseFilter: baseFilter,
            ),
          );
        },
        child: Container(
          height: 40,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          width: MediaQuery.of(context).size.width * .5 - 20,
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: AppDimensions.borderRadius,
            border: Border.all(
              color: color ?? AppColors.backgroundCard,
            ),
          ), //
          child: child,
        ),
      ),
    );
  }
}
