import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorly/app/shared/utils/analytics_helper.dart';
import 'package:smart_select/smart_select.dart';

import '../../../shared/database/database_provider.dart';
import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/utils/functions.dart';
import '../../../shared/widgets/custom_button_widget.dart';
import '../models/filter_model.dart';
import '../widgets/dropdown_double_filter_widget.dart';
import '../widgets/smart_select_widgets.dart';

class FilterComponent extends StatefulWidget {
  final int lowestPrice;
  final int highestPrice;
  final FilterOfferModel currentFilter;
  final FilterOfferModel baseFilter;
  final String location;
  final List<Make> makes;
  final List<Model> models;
  final List<String> years;

  final ValueChanged<FilterOfferModel> onFilter;
  FilterComponent(
    this.onFilter, {
    @required this.highestPrice,
    @required this.lowestPrice,
    @required this.location,
    @required this.makes,
    @required this.models,
    @required this.currentFilter,
    @required this.years,
    this.baseFilter,
  });

  @override
  _FilterComponentState createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  String make;
  String sortOrder;

  String model;
  int price;
  String location;
  String title;

  String startYear;
  String endYear;

  String startPrice;
  String endPrice;

  String maxOdometer;
  String minOdometer;

  List<String> modelsList;

  int get lenght {
    final max = widget.highestPrice;
    final min = widget.lowestPrice;

    return ((max - min) ~/ 100).toInt() + 1;
  }

  bool isLoading = false;

  List<String> sortOrders = [
    'Listed recently',
    'Lowest price',
    'Highest price',
    'Oldest vehicles',
    'Newest vehicles',
    'Lowest kms',
    'Highest kms',
  ];

  List<int> get prices {
    return [
      1,
      2,
      3,
      4,
      5,
      10,
      15,
      20,
      25,
      30,
      35,
      40,
      45,
      50,
      60,
      70,
      80,
      90,
      100,
      150,
      200
    ];
  }

  List<int> get odometerValues {
    return [
      100,
      1000,
      5000,
      10000,
      20000,
      30000,
      40000,
      50000,
      60000,
      70000,
      80000,
      90000,
      100000,
      120000,
      140000,
      160000,
      180000,
      200000,
      250000,
      300000
    ];
  }

  List<String> get years {
    var kYears = widget.years;
    if (!kYears.contains("Any")) {
      kYears.insert(0, "Any");
    }
    return kYears;
  }

  List<String> get odometerLabels {
    var formatter = NumberFormat.decimalPattern("en_NZ");
    var kOdometer = List<String>.generate(odometerValues.length,
        (i) => "${formatter.format(odometerValues[i])} km");
    if (!kOdometer.contains("Any")) {
      kOdometer.insert(0, "Any");
    }

    return kOdometer;
  }

  List<String> get priceLabels {
    var kPrice = List<String>.generate(prices.length, (i) => "${prices[i]}K");
    if (!kPrice.contains("Any")) {
      kPrice.insert(0, "Any");
    }
    return kPrice;
  }

  List<String> get models {
    var data = <String>[];

    if (widget.models == null) {
      return data;
    }

    for (var model in widget.models) {
      data.add(model.name.toString());
    }

    return data;
  }

  set models(List<String> lsModels) {
    models = lsModels;
  }

  List<String> getStringModels(List<Model> lsModels) {
    var ls = <String>[];
    for (var model in lsModels) {
      ls.add(model.name.toString());
    }
    return ls;
  }

  Future<List<String>> _getModels(String make) async {
    final dio = Dio();
    var models = <String>[];
    dio.options.baseUrl =
        "https://api.trademe.co.nz/v1/searchoptions.json?dependent_value=$make";
    final result = await dio.get("&key=used_car_model");

    final List data = result.data;
    for (var item in data) {
      final model = item["Value"];
      await models.add(model);
    }
    return models;
  }

  _initData() async {
    modelsList = await _getModels(make);
    if (mounted) setState(() {});
  }

  List<String> get makes {
    var data = <String>[];

    if (widget.makes == null) {
      return data;
    }

    for (var makes in widget.makes) {
      data.add(makes.name.toString());
    }
    data.insert(0, "Any");
    return data;
  }

  @override
  void initState() {
    super.initState();
    make = widget?.currentFilter?.make ?? "Any";
    location = widget?.location;
    sortOrder = widget?.currentFilter?.sortOrder ?? "Any";
    model = widget?.currentFilter?.model ?? "Any";
    startYear = widget?.currentFilter?.year == null
        ? "Any"
        : widget?.currentFilter?.year.toString();
    endYear = widget?.currentFilter?.yearMax == null
        ? "Any"
        : widget?.currentFilter?.yearMax.toString();
    startPrice = widget?.currentFilter?.price?.toString();
    endPrice = widget?.currentFilter?.priceMax?.toString();
    maxOdometer = widget?.currentFilter?.odometerMax?.toString();
    minOdometer = widget?.currentFilter?.odometer?.toString();

    modelsList = models;
    _initData();
  }

  String _getFormatedPrice(String price) {
    String formatedPrice;
    if (price == null || price == "Any") {
      formatedPrice = null;
    } else {
      formatedPrice = price.contains("K")
          ? price
          : "${price.substring(0, price.length - 3)}K";
    }
    return formatedPrice;
  }

  String _getFormatedOdometer(String str) {
    if (str == null || str == "Any") {
      return str;
    } else if (str.contains("km")) {
      return str;
    } else {
      var formatter = NumberFormat.decimalPattern("en_NZ");
      return "${formatter.format(int.parse(str.trim()))} km";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!modelsList.contains("Any") && modelsList.isNotEmpty) {
      modelsList.insert(0, "Any");
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(14.0),
          topRight: const Radius.circular(14.0),
        ),
      ),
      padding: AppDimensions.marginScreen,
      child: IndexedStack(
        index: isLoading ? 0 : 1,
        children: [
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColors.primary,
                ))
              : Container(),
          Column(
            children: [
              _buildHead(),
              SizedBox(height: 10),
              Divider(color: Colors.white),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SmartDropdownBottomsheetFilterWidget(
                        title: "Sort Order",
                        items: sortOrders,
                        selected: getSortOrderKey(sortOrder),
                        onChanged: (text) {
                          setState(() => sortOrder = text);
                        },
                      ),
                      DropdownFilterDoubleWidget(
                        title: "Price (\$)",
                        startItems: priceLabels,
                        endItems: priceLabels,
                        startSelected: _getFormatedPrice(startPrice),
                        endSelected: _getFormatedPrice(endPrice),
                        onStartChanged: (text) {
                          setState(() => startPrice = text);
                        },
                        onEndChanged: (text) {
                          setState(() => endPrice = text);
                        },
                      ),
                      SizedBox(height: 10),
                      DropdownFilterDoubleWidget(
                        title: "Odometer",
                        startItems: odometerLabels,
                        endItems: odometerLabels,
                        startSelected: _getFormatedOdometer(minOdometer),
                        endSelected: _getFormatedOdometer(maxOdometer),
                        onStartChanged: (text) {
                          setState(() => minOdometer = text);
                        },
                        onEndChanged: (text) {
                          setState(() => maxOdometer = text);
                        },
                      ),
                      SmartDropdownFullscreenFilterWidget(
                        title: "Make",
                        items: makes,
                        selected: make ?? "Any ",
                        onChanged: (text) async {
                          String result = text;
                          if (result != "Any" && result != make) {
                            if (mounted) {
                              setState(() {
                                isLoading = true;
                              });
                            }
                            List<String> res = await _getModels(result);
                            if (mounted) {
                              setState(() {
                                make = result;
                                modelsList = res;
                                if (!modelsList.contains("Any")) {
                                  modelsList.insert(0, "Any");
                                }
                                isLoading = false;
                                model = null;
                              });
                            }
                          } else if (result == "Any") {
                            if (mounted) {
                              setState(() {
                                make = result;
                                modelsList = [];
                                model = null;
                              });
                            }
                          }
                        },
                      ),
                      SmartDropdownFullscreenFilterWidget(
                        title: "Model",
                        items: modelsList,
                        selected: model ?? "Any",
                        isDisable: modelsList.isEmpty,
                        key: ValueKey(make),
                        onChanged: (text) async {
                          if (mounted) {
                            setState(() {
                              model = text;
                            });
                          }
                        },
                      ),
                      DropdownFilterDoubleWidget(
                        title: "Year",
                        startItems: years,
                        endItems: years,
                        startSelected: startYear,
                        endSelected: endYear,
                        onStartChanged: (text) {
                          setState(() => startYear = text);
                        },
                        onEndChanged: (text) {
                          setState(() => endYear = text);
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              CustomButtonWidget(
                text: "Apply Filter",
                onTap: () {
                  FilterOfferModel ff = widget.currentFilter;
                  ff.keywords = make;
                  ff.sortOrder =
                      sortOrder != null ? titleToSortOrder(sortOrder) : null;
                  ff.location = location;
                  ff.model = model;
                  ff.make = make;
                  ff.priceMax =
                      endPrice != null ? endPrice.replaceAll("K", "000") : null;
                  ff.price = startPrice != null
                      ? startPrice.replaceAll("K", "000")
                      : null;

                  ff.yearMax = int.tryParse(endYear) != null
                      ? int.tryParse(endYear)
                      : null;
                  ff.year = int.tryParse(startYear) != null
                      ? int.tryParse(startYear)
                      : null;
                  ff.odometerMax = maxOdometer != null
                      ? maxOdometer.replaceAll("km", "").replaceAll(",", "")
                      : null;
                  ff.odometer = minOdometer != null
                      ? minOdometer.replaceAll("km", "").replaceAll(",", "")
                      : null;
                  widget.onFilter(ff);
                  AnalyticsHelper.registerSearchFilter();
                  Navigator.of(context).pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHead() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          child: Icon(
            Icons.cancel,
            color: AppColors.primary,
          ),
          onTap: () => Navigator.of(context).pop(context),
        ),
        Text(
          "Filters",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () {
            if (widget.baseFilter != null) {
              widget.onFilter(FilterOfferModel(
                location: location,
                make: widget.baseFilter.make,
                model: widget.baseFilter.model,
                year: widget.baseFilter.year,
                yearMax: widget.baseFilter.yearMax,
                price: widget.baseFilter.price,
                priceMax: widget.baseFilter.priceMax,
              ));
            } else {
              widget.onFilter(FilterOfferModel(
                location: location,
                keywords: make,
                page: 1,
              ));
            }

            Navigator.of(context).pop(context);
          },
          child: Text(
            "Reset",
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
