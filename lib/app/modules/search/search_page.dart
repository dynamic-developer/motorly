import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shimmer/shimmer.dart';
import '../../shared/constants/location_constants.dart';
import '../../shared/database/database_provider.dart';
import '../../shared/repositories/database_repository.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/text_styles.dart';
import '../../shared/utils/analytics_helper.dart';
import '../home/models/filter_model.dart';
import '../home/widgets/dropdown_filter_widget.dart';
import '../home/widgets/filter_widget.dart';
import '../motor_details/widgets/app_bar_widget.dart';
import '../motor_details/widgets/failure_widget.dart';
import '../motor_details/widgets/shimmer_offers.dart';
import 'cubits/search/search_cubit.dart';
import 'pages/results_page.dart';
import 'widgets/research_widget.dart';

class SearchArgs {
  final String keyword;
  final FilterOfferModel filter;

  SearchArgs({this.keyword, this.filter});
}

class SearchPage extends StatefulWidget {
  final SearchArgs args;
  SearchPage({@required this.args});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool filterIsActived = false;
  var _location = "New Zealand";
  FilterOfferModel filterOffer;

  final _searchCubit = Modular.get<SearchCubit>();

  final _scrollController = ScrollController();

  List<Make> makes;
  List<Model> models;
  final _databaseRepository = Modular.get<DatabaseRepository>();
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    var _filter = widget.args.filter ??
        FilterOfferModel(
            keywords: widget.args.keyword,
            location: _location == "New Zealand" ? null : _location,
            price: "1000",
            priceMax: "200000");
    filterOffer = _filter;
    textEditingController.text = widget.args.keyword;
    print("FILTER OBJ ::${_filter.toJson()}");
    super.initState();
    _searchCubit.load(_filter);
    _fetchMakeModels();
  }

  void _fetchMakeModels() async {
    makes = await _databaseRepository.fetchAllMakes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsHelper.setKeywordsSearchPage();
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              children: [
                SizedBox(height: 23),
                ResearchWidget(_location, textEditingController, filterOffer),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: DropdownFilterWidget(
                        items: offersLocations() ?? [],
                        selected: _location,
                        onChanged: (text) {
                          setState(() => _location = text);
                          filterOffer.location =
                              _location == "New Zealand" ? null : _location;
                          onFilter(filterOffer);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: FilterWidget(
                            onFilter: onFilter,
                            baseFilter: widget.args.filter,
                            makes: makes,
                            models: [],
                            years: offersYears(),
                            isActived: filterIsActived,
                            currentFilter: filterOffer),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 23),
                BlocBuilder<SearchCubit, SearchState>(
                  bloc: _searchCubit,
                  builder: (context, state) {
                    return state.maybeWhen(
                      loadLoaded: (item) => ResultsPage(
                        filterOfferModel: item.filter,
                        searchResult: item,
                        controller: _scrollController,
                      ),
                      loadLoading: _buildLoading,
                      loadFailure: (message) => FailureWidget(message),
                      orElse: () => Container(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget _buildLoading() {
    return Shimmer.fromColors(
      baseColor: AppColors.gray70,
      highlightColor: AppColors.backgroundWidget,
      enabled: true,
      child: ShimmerOffersWidget(),
    );
  }

  List<String> offersLocations() {
    var items = LocationConstants.list;
    return items;
  }

  void onFilter(FilterOfferModel filter) {
    var ff = FilterOfferModel(
      page: 1,
      keywords: textEditingController.text,
      location: _location == "New Zealand" ? null : _location,
      sortOrder: filter.sortOrder,
      year: filter.year,
      yearMax: filter.yearMax,
      make: filter.make,
      priceMax: filter.priceMax,
      price: filter.price,
      pageSize: filter.pageSize,
      model: filter.model,
      type: filter.type,
      odometer: filter.odometer,
      odometerMax: filter.odometerMax,
    );

    print(" onFilter ${ff.location}" + ff.toJson().toString());

    _searchCubit.load(ff);

    setState(() {
      if (filter == null) {
        filterIsActived = false;
      } else {
        filterOffer = ff;
        _location = filterOffer?.location;
        filterIsActived = true;
      }
    });
  }
}
