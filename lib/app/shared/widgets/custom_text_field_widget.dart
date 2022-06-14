import 'package:flutter/material.dart';

import '../style/text_styles.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function onTap;
  final bool obscureText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool disable;
  final bool autoFocus;
  final FocusNode focusNode;
  final String message;
  final int lines;
  final void Function(String) onChanged;

  final void Function(String) onValidator;

  CustomTextFieldWidget({
    this.hintText,
    this.keyboardType,
    @required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.obscureText = false,
    this.disable = false,
    this.focusNode,
    this.autoFocus = false,
    this.message,
    this.onChanged,
    this.onValidator,
    this.lines = 1,
  });

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        TextFormField(
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
          validator: widget.onValidator,
          style: _textStyle.copyWith(color: Theme.of(context).canvasColor),
          maxLines: widget.lines,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).hoverColor),
            ),

            labelText: widget.hintText,
            //hintText: widget.hintText,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: TextStyle(
              height: 0,
              color: Theme.of(context).hoverColor,
            ),
            contentPadding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: 15,
              bottom: 15,
            ),
            prefixIcon: widget?.prefixIcon,
            suffixIcon: widget?.suffixIcon,
          ),
        ),
        if (widget?.message != null)
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              widget.message,
              style: AppTextStyles.primaryH1Light.copyWith(
                color: Theme.of(context).hoverColor,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  static final TextStyle _textStyle = AppTextStyles.primaryH1Medium.copyWith(
    color: Colors.grey,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
}
