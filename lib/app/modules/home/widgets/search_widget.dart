import 'package:flutter/material.dart';

import '../../../shared/utils/analytics_helper.dart';
import '../../search/search_module.dart';
import '../../search/search_page.dart';
import 'search_textfield_widget.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget();

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _formKey = GlobalKey<FormState>();

  final _placeController = TextEditingController();

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
              controller: _placeController,
              onSearch: (value) {
                if (_formKey.currentState.validate()) {
                  AnalyticsHelper.registerFreeSearchText(_placeController.text);
                  Navigator.of(context).pushNamed(
                    SearchModule.route,
                    arguments: SearchArgs(keyword: _placeController.text),
                  );
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
