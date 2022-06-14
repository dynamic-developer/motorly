import 'package:flutter/material.dart';

import '../../../shared/style/text_styles.dart';

class SearchTextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function onTap;
  final bool obscureText;
  final Widget prefixIcon;
  final String initialValue;
  final Widget suffixIcon;
  final bool disable;
  final bool autoFocus;
  final FocusNode focusNode;
  final String message;
  final int lines;
  final void Function(String) onChanged;
  final void Function(String) onSearch;

  final void Function(String) onValidator;

  SearchTextFieldWidget({
    this.hintText,
    this.keyboardType,
    @required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.onTap,
    this.obscureText = false,
    this.disable = false,
    this.focusNode,
    this.autoFocus = false,
    this.message,
    this.onChanged,
    this.onValidator,
    this.lines = 1,
    @required this.onSearch,
  });

  @override
  _SearchTextFieldWidgetState createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.initialValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            TextField(
              textAlign: TextAlign.left,
              focusNode: widget.focusNode,
              keyboardType: widget?.keyboardType,
              obscureText: widget?.obscureText,
              controller: widget?.controller,
              autofocus: widget?.autoFocus,
              onChanged: widget?.onChanged,
              onTap: widget.onTap,
              enableInteractiveSelection: widget?.onTap == null,
              enabled: !widget.disable,
              readOnly: widget.onTap != null,

              //validator: widget.onValidator,
              textInputAction: TextInputAction.search,
              onSubmitted: widget.onSearch,
              style: _textStyle.copyWith(color: Theme.of(context).canvasColor),
              maxLines: widget.lines,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(53, 53, 53, 0.8),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(137, 138, 141, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(137, 138, 141, 1)),
                ),
                // labelText: widget.hintText,
                hintText: widget.hintText,

                floatingLabelBehavior: FloatingLabelBehavior.auto,

                hintStyle: _textStyle.copyWith(
                  color: Color.fromRGBO(137, 138, 141, 1),
                  fontSize: 13,
                ),
                contentPadding: EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Icon(
                    Icons.search,
                    color: Color.fromRGBO(137, 138, 141, 1),
                  ),
                ),
                suffixIcon: widget?.suffixIcon,
              ),
            ),
          ],
        ),
        if (widget?.message != null)
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(widget.message,
                style: _textStyle.copyWith(
                    color: Color.fromRGBO(137, 138, 141, 1))),
          ),
      ],
    );
  }

  static final TextStyle _textStyle =
      AppTextStyles.primaryH1PlateEntry.copyWith(
    color: Color.fromRGBO(137, 138, 141, 1),
    fontWeight: FontWeight.w400,
  );
}
