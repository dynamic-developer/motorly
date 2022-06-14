import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';

class DropdownFilterWidget extends StatefulWidget {
  final ValueChanged onChanged;
  final String title;
  final List<String> items;
  final String selected;

  DropdownFilterWidget({
    @required this.onChanged,
    @required this.items,
    this.title,
    this.selected,
  });

  @override
  State<DropdownFilterWidget> createState() => _DropdownFilterWidgetState();
}

class _DropdownFilterWidgetState extends State<DropdownFilterWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    print("LOCATION ::::: ${widget.selected}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(height: 10),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: AppDimensions.borderRadius,
            border: Border.all(
              color: AppColors.backgroundCard,
              style: BorderStyle.solid,
            ),
          ),
          padding: EdgeInsets.only(left: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              menuMaxHeight: 500,
              hint: Text(
                '${widget.selected ?? "New Zealand"}',
                style: TextStyle(
                  // fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              isExpanded: true,
              iconEnabledColor: Colors.white,
              iconSize: 30.0,
              items: widget.items.map(
                (value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
