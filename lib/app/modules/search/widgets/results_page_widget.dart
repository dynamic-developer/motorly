import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/style/colors.dart';
import '../../home/models/filter_model.dart';
import '../cubits/search/search_cubit.dart';

class ResultsPageWidget extends StatelessWidget {
  ResultsPageWidget({
    Key key,
    this.totalResultsPage,
    this.currentPage,
    this.currentListPage,
    this.totalListPage,
    this.lenghtListPage,
    this.keywords,
    this.scrollController,
  }) : super(key: key);

  final int totalResultsPage;
  final int currentPage;
  final int currentListPage;
  final int totalListPage;
  final int lenghtListPage;
  final String keywords;
  final ScrollController scrollController;

  final _searchCubit = Modular.get<SearchCubit>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PageButtonWidget(
          boxColor: AppColors.primary,
          content: Icon(
            Icons.arrow_left,
            color: Colors.white,
          ),
          onTap: currentListPage == 1
              ? null
              : () {
                  _searchCubit.load(
                    FilterOfferModel(
                      keywords: keywords,
                      page: (currentListPage - 1) * 4,
                    ),
                  );
                  scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: Duration(milliseconds: 600),
                    curve: Curves.fastOutSlowIn,
                  );
                },
        ),
        ...List.generate(
          lenghtListPage,
          (index) {
            var item = (index + 1) + (currentListPage - 1) * 4;

            return PageButtonWidget(
              boxColor:
                  item == currentPage ? AppColors.primary : Colors.transparent,
              content: Text(
                "$item",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              onTap: item == currentPage
                  ? null
                  : () {
                      _searchCubit.load(
                        FilterOfferModel(
                          keywords: keywords,
                          page: item,
                        ),
                      );
                      scrollController.animateTo(
                        scrollController.position.minScrollExtent,
                        duration: Duration(milliseconds: 600),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
            );
          },
        ),
        PageButtonWidget(
          boxColor: AppColors.primary,
          content: Icon(
            Icons.arrow_right,
            color: Colors.white,
          ),
          onTap: currentListPage == totalListPage
              ? null
              : () {
                  _searchCubit.load(
                    FilterOfferModel(
                      keywords: keywords,
                      page: (currentListPage) * 4 + 1,
                    ),
                  );
                  scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: Duration(milliseconds: 600),
                    curve: Curves.fastOutSlowIn,
                  );
                },
        ),
      ],
    );
  }
}

class PageButtonWidget extends StatelessWidget {
  const PageButtonWidget({
    Key key,
    @required this.boxColor,
    @required this.onTap,
    @required this.content,
  }) : super(key: key);

  final Color boxColor;
  final Function() onTap;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.primary,
          width: 1,
        ),
      ),
      child: InkWell(
        child: Center(child: content),
        onTap: onTap,
      ),
    );
  }
}
