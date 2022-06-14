import 'package:flutter/material.dart';
import '../../../shared/style/colors.dart';

class PaginationOfferWidget extends StatelessWidget {
  PaginationOfferWidget({
    Key key,
    @required this.totalPages,
    @required this.currentPage,
    @required this.scrollController,
    @required this.onChangePage,
  }) : super(key: key);

  final int totalPages;
  final int currentPage;
  final ScrollController scrollController;
  final Function(int) onChangePage;

  int get totalPaginationLenght {
    return totalPages ~/ 4 + (totalPages % 4 == 0 ? 0 : 1);
  }

  int get currentPaginationList {
    return (currentPage - 1) ~/ 4 + 1;
  }

  int get totalLenghtActual {
    if (currentPaginationList == totalPaginationLenght && totalPages % 4 != 0) {
      return totalPages % 4;
    }

    return 4;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentPaginationList > 1)
              PageButtonWidget(
                boxColor: AppColors.primary,
                content: Icon(
                  Icons.arrow_left,
                  color: Colors.white,
                ),
                onTap: currentPaginationList == 1
                    ? null
                    : () {
                        onChangePage((currentPaginationList - 1) * 4);
                        // scrollController.animateTo(
                        //   scrollController.position.minScrollExtent,
                        //   duration: Duration(milliseconds: 600),
                        //   curve: Curves.fastOutSlowIn,
                        // );
                      },
              ),
            ...List.generate(
              totalLenghtActual,
              (index) {
                var position = (index + 1) + (currentPaginationList - 1) * 4;

                return PageButtonWidget(
                  boxColor: position == currentPage
                      ? AppColors.primary
                      : Colors.transparent,
                  content: Text(
                    "$position",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  onTap: position == currentPage
                      ? null
                      : () {
                          onChangePage(position);
                          scrollController.animateTo(
                            scrollController.position.minScrollExtent,
                            duration: Duration(milliseconds: 600),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                );
              },
            ),
            if (currentPaginationList != totalPaginationLenght)
              PageButtonWidget(
                boxColor: AppColors.primary,
                content: Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                ),
                onTap: currentPaginationList == totalPaginationLenght
                    ? null
                    : () {
                        onChangePage((currentPaginationList * 4) + 1);
                        // _offersCubit.load(
                        //   FilterOfferModel(
                        //     model: motor.model,
                        //     make: motor.make,
                        //     year: motor.year,
                        //     yearMax: motor.year,
                        //     page: (currentPaginationList * 4) + 1,
                        //   ),
                        // );
                        scrollController.animateTo(
                          scrollController.position.minScrollExtent,
                          duration: Duration(milliseconds: 600),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
              ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Page $currentPage of $totalPages",
          style: TextStyle(
            fontSize: 12,
          ),
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
      margin: EdgeInsets.symmetric(horizontal: 5),
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
