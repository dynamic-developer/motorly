import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/shared/utils/analytics_helper.dart';

import '../../../shared/style/colors.dart';
import '../../home/cubits/filter/filter.cubit.dart';
import '../../home/cubits/navigation/navigation.cubit.dart';
import '../../home/models/filter_model.dart';

class StoryItemWidget extends StatelessWidget {
  final String label;
  final FilterOfferModel filter;
  final String storyImage;
  final _navigationCubit = Modular.get<NavigationCubit>();
  final _filterCubit = Modular.get<FilterCubit>();

  StoryItemWidget(
      {Key key,
      @required this.label,
      @required this.filter,
      @required this.storyImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              _filterCubit.emit(filter);
              AnalyticsHelper.tappedStory(filter.price);
              _navigationCubit.emit(1);
            },
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 27.0,
              child: CircleAvatar(
                  backgroundImage: AssetImage(storyImage), radius: 24),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
