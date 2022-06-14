import 'package:flutter/material.dart';

import '../../../shared/utils/analytics_helper.dart';
import '../../../shared/widgets/custom_button_widget.dart';
import '../../motor_details/motor_details_module.dart';
import 'input_plate_textfield_widget.dart';

class InsertPlateWidget extends StatefulWidget {
  InsertPlateWidget();

  @override
  _InsertPlateWidgetState createState() => _InsertPlateWidgetState();
}

class _InsertPlateWidgetState extends State<InsertPlateWidget> {
  final _formKey = GlobalKey<FormState>();

  final _placeController = TextEditingController();

  String _lastSearch;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 170,
            child: InputPlateTextFieldWidget(
                hintText: "Enter plate",
                controller: _placeController,
                onValidator: (text) {
                  if (text.isEmpty) {
                    return "Can't be empty :)";
                  }
                  if (text.replaceAll(RegExp(' '), '').length > 6) {
                    return "That's too many characters =P";
                  }
                  return null;
                },
                onFieldSubmitted: (val) {
                  _lastSearch = val;

                  if (_formKey.currentState.validate()) {
                    AnalyticsHelper.registerInsertedPlate(_lastSearch);
                    Navigator.of(context).pushNamed(
                      MotorDetailsModule.route,
                      arguments: _lastSearch,
                    );
                  }
                }),
          ),
          SizedBox(width: 7),
          CustomButtonWidget(
            text: "GO",
            buttonWidth: 80,
            onTap: () async {
              _lastSearch = _placeController.text;

              if (_formKey.currentState.validate()) {
                AnalyticsHelper.registerInsertedPlate(_lastSearch);
                Navigator.of(context).pushNamed(
                  MotorDetailsModule.route,
                  arguments: _lastSearch,
                );
              }

              // var _prefs = await SharedPreferences.getInstance();
              // await _prefs.setString('lastSearch', _lastSearch);
            },
          ),
        ],
      ),
    );
  }
}
