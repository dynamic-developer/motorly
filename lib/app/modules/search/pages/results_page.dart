import 'package:flutter/material.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../home/models/filter_model.dart';
import '../../home/models/new_offer_model.dart';
import '../../home/widgets/offers_details_widget.dart';
import '../repository/search_api.dart';
import '../repository/search_repository.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage(
      {Key key,
      @required this.searchResult,
      @required this.controller,
      @required this.filterOfferModel})
      : super(key: key);

  final SearchResult searchResult;
  final ScrollController controller;
  final FilterOfferModel filterOfferModel;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  GlobalKey key;

  int pageCount = 2; //because first page initialize at the very first step
  List<NewOfferModel> result = [];
  bool isLoadNext = true;
  bool isFirst = true;
  FilterOfferModel filterOffer;

  _loadListener() async {
    if (isLoadNext &&
        widget.controller.offset ==
            widget.controller.position.maxScrollExtent) {
      print(
          "SCROLL CONTROLLER VALUE::: ${widget.controller.offset} ${widget.controller.position.maxScrollExtent}");

      filterOffer.page = pageCount;
      // ignore: omit_local_variable_types
      List<NewOfferModel> res = await SearchAPI().getPageData(
        pageCount,
        filterOffer,
      );
      result = [...result, ...res];
      print(res);
      if (res.length < 10) {
        isLoadNext = false;
      }

      pageCount++;
      if (mounted) setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_loadListener);
  }

  @override
  Widget build(BuildContext context) {
    if (isFirst) {
      filterOffer = widget.filterOfferModel;
      result = [...widget.searchResult.offers];
      isFirst = false;
    }
    return Column(
      children: [
        widget.searchResult.offers.isNotEmpty
            ? OffersDetailsWidget(result, widget.searchResult.totalCount)
            : Container(
                child: Center(
                child: Text(
                  "Please try again.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.primaryH1Medium,
                ),
              )),
        if (result.isNotEmpty &&
            isLoadNext &&
            result.length != widget.searchResult.totalCount)
          CircularProgressIndicator(
            color: AppColors.primary,
          ),
      ],
    );
  }
}
