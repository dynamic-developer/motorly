import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/modules/home/models/new_offer_model.dart';
import 'package:motorly/app/modules/search/repository/search_api.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/constants/location_constants.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';
import '../../home/models/filter_model.dart';
import '../../home/models/models.dart';
import '../../home/widgets/dropdown_filter_widget.dart';
import '../../home/widgets/filter_widget.dart';
import '../../home/widgets/no_offers_widget.dart';
import '../../home/widgets/offers_details_widget.dart';
import '../cubits/offers/offers_cubit.dart';

import 'shimmer_offers.dart';
import 'tabs_widget.dart';

class OffersWidget extends StatefulWidget {
  const OffersWidget({
    Key key,
    @required this.url,
    @required this.motor,
    @required this.scrollController,
  }) : super(key: key);

  final MotorModel motor;
  final String url;
  final ScrollController scrollController;
  // final FilterOfferModel filter;

  @override
  _OffersWidgetState createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  bool _isSimilar = false;
  String location = "New Zealand";

  bool filterIsActived = false;
  int pageCount = 2; //because first page initialize at the very first step
  FilterOfferModel filterOffer;
  List<NewOfferModel> result = [];
  bool isLoadNext = true;
  bool isFirst = true;
  void onFilter(FilterOfferModel filter) {
    filter.page = 1;
    pageCount = 2;
    filter.fetchSimilar = false;
    _offersCubit.load(filter);
    print(
        "MAKE TEST OFFER_WIDGET.DART --->onFilter --> filter.sort :: ${filter.sortOrder}");

    setState(() {
      if (filter == null) {
        filterIsActived = false;
      } else {
        filterOffer = filter;
        // _location = filterOffer?.location;
        filterIsActived = true;
      }
    });
  }

  List<String> offersLocations() {
    var items = LocationConstants.list;
    return items;
  }

  List<String> offersYears() {
    var items = <String>[];

    var startingYear = 1900;
    var currentYear = DateTime.now().year;

    for (var year = currentYear; year >= startingYear; year--) {
      items.add(year.toString());
    }
    return items;
  }

  final _offersCubit = Modular.get<OffersCubit>();

  @override
  void initState() {
    // TODO: implement initState

    filterOffer = FilterOfferModel(
        page: 1,
        make: widget.motor.make,
        model: widget.motor.model,
        year: widget.motor.year,
        yearMax: widget.motor.year,
        location: location);
    widget.scrollController.addListener(_loadListener);
    super.initState();
  }

  _loadListener() async {
    print(
        "SCROLL CONTROLLER VALUE::: ${widget.scrollController.offset} ${widget.scrollController.position.maxScrollExtent}");
    if (isLoadNext &&
        widget.scrollController.offset ==
            widget.scrollController.position.maxScrollExtent) {
      filterOffer.page = pageCount;

      // ignore: omit_local_variable_types
      List<NewOfferModel> res =
          await SearchAPI().getPageData(pageCount, filterOffer);
      result = [...result, ...res];
      if (res.length < 10) {
        isLoadNext = false;
      }

      pageCount++;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print("MAKE TEST OFFER_WIDGET.DART ---> build make :: ${filterOffer.make}");
    print(
        "MAKE TEST OFFER_WIDGET.DART ---> build model :: ${filterOffer.model}");
    print("MAKE TEST OFFER_WIDGET.DART ---> build page :: ${filterOffer.page}");
    print("MAKE TEST OFFER_WIDGET.DART ---> build location :: $location");

    return BlocConsumer<OffersCubit, OffersState>(
      bloc: _offersCubit,
      listener: (context, state) {
        if (state is OffersLoaded) {
          setState(() {
            _isSimilar = state.data.isSimilar;
          });
        }
      },
      builder: (context, state) {
        if (state is OffersLoading) {
          isFirst = true;
          isLoadNext = true;
          return Shimmer.fromColors(
            baseColor: AppColors.gray70,
            highlightColor: AppColors.backgroundWidget,
            enabled: true,
            child: ShimmerOffersWidget(),
          );
        }

        if (state is OffersLoaded) {
          if (isFirst) {
            result = [...state.data.offers];
            isFirst = false;
          }

          return Column(
            children: [
              SizedBox(height: 24),
              TabsWidget(url: widget.url),
              if (_isSimilar && state.data.offers.isNotEmpty)
                Container(
                  margin: EdgeInsets.all(13),
                  child: Text(
                    'Oops! No offers for this specific model/year. Check-out similar ones:',
                    style: AppTextStyles.primaryBoldDescription.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                ),
              //if (!_isSimilar)
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: DropdownFilterWidget(
                        items: offersLocations() ?? [],
                        selected: location,
                        onChanged: (text) {
                          print("LOCATION onChange ::: ${text}");
                          setState(() => location = text);
                          filterOffer.location = location;
                          onFilter(filterOffer);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: FilterWidget(
                        location: location,
                        currentFilter: filterOffer,
                        onFilter: onFilter,
                        years: offersYears(),
                        highestPrice: widget?.motor?.price?.stats?.max,
                        lowestPrice: widget?.motor?.price?.stats?.min,
                        makes: widget?.motor?.makes,
                        models: widget?.motor?.models,
                        isActived: filterIsActived,
                        baseFilter: FilterOfferModel(
                          page: 1,
                          make: widget.motor.make,
                          model: widget.motor.model,
                          year: widget.motor.year,
                          yearMax: widget.motor.year,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 13),
              result.isNotEmpty
                  ? OffersDetailsWidget(
                      result,
                      state.data.totalCount,
                    )
                  : NoOffersWidget(),
              if (isLoadNext &&
                  result.isNotEmpty &&
                  result.length != state.data.totalCount)
                CircularProgressIndicator(
                  color: AppColors.primary,
                ),
            ],
          );
        }

        if (state is OffersFailure) {
          return Center(
            child: Text(state.error),
          );
        }

        return Container();
      },
    );
  }
}
