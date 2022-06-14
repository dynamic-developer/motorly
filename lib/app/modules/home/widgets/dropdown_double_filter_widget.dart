import 'package:flutter/material.dart';

import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';

class DropdownFilterDoubleWidget extends StatefulWidget {
  final ValueChanged onStartChanged;
  final ValueChanged onEndChanged;

  final String title;
  final List<String> startItems;
  final List<String> endItems;

  final String endSelected;
  final String startSelected;

  DropdownFilterDoubleWidget({
    @required this.onStartChanged,
    @required this.onEndChanged,
    @required this.startItems,
    @required this.endItems,
    @required this.title,
    this.startSelected,
    this.endSelected,
  });

  @override
  State<DropdownFilterDoubleWidget> createState() =>
      _DropdownFilterDoubleWidgetState();
}

class _DropdownFilterDoubleWidgetState
    extends State<DropdownFilterDoubleWidget> {
  List<String> _endItems;
  List<String> _startItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _endItems = widget.endItems;
    _startItems = widget.startItems;
  }

  @override
  Widget build(BuildContext context) {
    print("REBUILD DOUBLE DROPDOWN");
    print(_endItems);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDrop(
              items: _startItems,
              selected: widget.startSelected,
              onChanged: (val) {
                widget.onStartChanged(val);
                setState(() {
                  _endItems =
                      returnMaxValues(items: widget.endItems, threshold: val);
                });
              },
            ),
            Text("-"),
            _buildDrop(
              items: _endItems,
              selected: widget.endSelected,
              onChanged: (val) {
                widget.onEndChanged(val);
                setState(() {
                  _startItems = returnMaxValues(
                      items: widget.endItems,
                      threshold: val,
                      isReturnMax: false);
                });
              },
            )
          ],
        ),
      ],
    );
  }

  List<String> returnMaxValues(
      {List<String> items, String threshold, bool isReturnMax = true}) {
    //thresh
    if (threshold == "Any" || threshold == null) {
      return items;
    } else {
      var _threshold = double.tryParse(threshold
          .replaceAll(r"K", "")
          .replaceAll(" km", "")
          .replaceAll(",", ""));
      print(" threshold $threshold $_threshold");
      if (_threshold != null) {
        var _items = items.where((e) {
          if (e == "Any") {
            return true;
          } else {
            return isReturnMax
                ? double.parse(e
                        .replaceAll(r"K", "")
                        .replaceAll(" km", "")
                        .replaceAll(",", "")) >
                    _threshold
                : double.parse(e
                        .replaceAll(r"K", "")
                        .replaceAll(" km", "")
                        .replaceAll(",", "")) <
                    _threshold;
          }
        }).toList();
        return _items;
      } else {
        return items;
      }
    }
  }

  Widget _buildDrop({
    String selected,
    List<String> items,
    ValueChanged onChanged,
  }) {
    return Builder(
      builder: (context) {
        return Container(
          height: 40,
          width: MediaQuery.of(context).size.width * .35,
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
              hint: Text(
                '${selected ?? "Any"}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              isExpanded: true,
              iconEnabledColor: Colors.white,
              iconSize: 30.0,
              items: items.map(
                (value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              onChanged: onChanged,
            ),
          ),
        );
      },
    );
  }
}
