import 'package:flutter/material.dart';
import 'package:motorly/app/shared/style/app_dimensions.dart';
import 'package:motorly/app/shared/style/colors.dart';
import 'package:smart_select/smart_select.dart';

class SmartDropdownBottomsheetFilterWidget extends StatelessWidget {
  final Function(String) onChanged;
  final String title;
  final List<String> items;
  final String selected;

  const SmartDropdownBottomsheetFilterWidget({
    @required this.onChanged,
    @required this.items,
    this.title,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SmartSelect.single(
      
      value: selected ?? "Any",
   
      choiceItems:
          items.map((e) => S2Choice<String>(value: e, title: e)).toList(),
      onChange: (text) {
        onChanged(text.value.toString());
      },
      title: title,
      modalType: S2ModalType.bottomSheet,
      tileBuilder: (context, state) {
        String value = state.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                state.showModal();
              },
              child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: AppDimensions.borderRadius,
                  border: Border.all(
                    color: AppColors.backgroundCard,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Text(value,
                    style: TextStyle(
                      fontSize: 16,
                    )),
                padding: EdgeInsets.only(left: 10),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SmartDropdownFullscreenFilterWidget extends StatelessWidget {
  final Function(String) onChanged;
  final String title;
  final List<String> items;
  final String selected;
  final bool isDisable;
  final Key key ;

  const SmartDropdownFullscreenFilterWidget({
    @required this.onChanged,
    @required this.items,
    this.title,
    this.selected,
    this.isDisable = false,
    this.key = const ValueKey("key")
  });

  @override
  Widget build(BuildContext context) {
    print("in dropdown::: Model ::: ${selected}");
    var _selected = selected;
    return SmartSelect.single(
      
      key:key,
      value: _selected,
      modalStyle: S2ModalStyle(backgroundColor: Colors.white),
    
      modalFilter: true,
      modalFilterAuto: true,
      choiceItems:
          items.map((e) => S2Choice<String>(value: e, title: e)).toList(),
      onChange: (text) {
        onChanged(text.value.toString());
      },
      title: title,

      modalType: S2ModalType.fullPage,
      tileBuilder: (context, state) {
        String value = state.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDisable ? Colors.grey : Colors.white,
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: !isDisable
                  ? () {
                      state.showModal();
                    }
                  : null,
              child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: AppDimensions.borderRadius,
                  border: Border.all(
                    color: AppColors.backgroundCard,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Text(isDisable ? "Any" : value,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDisable ? Colors.grey : Colors.white,
                    )),
                padding: EdgeInsets.only(left: 10),
              ),
            ),
          ],
        );
      },
    );
  }
}
