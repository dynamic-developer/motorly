import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/utils/analytics_helper.dart';
import '../../home/models/filter_model.dart';
import '../../home/widgets/search_textfield_widget.dart';
import '../cubits/search/search_cubit.dart';

class ResearchWidget extends StatefulWidget {
  final String location;
  final TextEditingController textEditingController;
  final FilterOfferModel filter;
  ResearchWidget(this.location, this.textEditingController, this.filter);

  @override
  _ResearchWidgetState createState() => _ResearchWidgetState();
}

class _ResearchWidgetState extends State<ResearchWidget> {
  final _formKey = GlobalKey<FormState>();

  // final _placeController = TextEditingController();

  final _searchCubit = Modular.get<SearchCubit>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: SearchTextFieldWidget(
              hintText: "Search offers",
              controller: widget.textEditingController,
              initialValue: widget.textEditingController.text,
              onSearch: (p0) {
                if (_formKey.currentState.validate()) {
                  AnalyticsHelper.registerFreeSearchText(
                      widget.textEditingController.text);
                  var _filter = FilterOfferModel(
                    keywords: widget.textEditingController.text,
                    page: 1,
                    location: widget.location,
                    year: widget.filter.year,
                    yearMax: widget.filter.yearMax,
                    make: widget.filter.make,
                    model: widget.filter.model,
                    type: widget.filter.type,
                    sortOrder: widget.filter.sortOrder,
                    price: widget.filter.price,
                    priceMax: widget.filter.priceMax,
                    odometer: widget.filter.odometer,
                    odometerMax: widget.filter.odometerMax,
                    pageSize: 10,
                  );
                  _searchCubit.load(_filter);
                  // _searchCubit.load(_filter);
                }
              },
              onValidator: (text) {
                if (text.isEmpty) {
                  return "Please type your search";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
