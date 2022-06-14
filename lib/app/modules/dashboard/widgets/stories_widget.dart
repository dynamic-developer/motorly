import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/shared/utils/analytics_helper.dart';

import '../../../shared/models/story_item_model.dart';
import '../../home/cubits/filter/filter.cubit.dart';
import '../../home/cubits/navigation/navigation.cubit.dart';
import '../../home/models/filter_model.dart';
import 'story_item_widget.dart';

class StoriesWidget extends StatelessWidget {
  final List<StoryItem> storiesList;

  StoriesWidget({Key key, this.storiesList}) : super(key: key);
  final _navigationCubit = Modular.get<NavigationCubit>();
  final _filterCubit = Modular.get<FilterCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Container(
                  height: 94,
                  child: Stack(
                    children: [
                      InkWell(
                          onTap: () {
                            _filterCubit.emit(FilterOfferModel(
                                keywords: "",
                                page: 1,
                                pageSize: 10,
                                sortOrder: 'expiryDate desc'));
                            AnalyticsHelper.tappedBrowseAll();
                            _navigationCubit.emit(1);
                          },
                          child: Image.asset('assets/stories/all-stories.png',
                              width: 60, height: 60)),
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0, left: 5),
                        child: Text(
                          "Browse All",
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: storiesList.length,
                itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: StoryItemWidget(
                      label: storiesList[index].label,
                      filter: storiesList[index].filter,
                      storyImage: storiesList[index].assetImage,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
