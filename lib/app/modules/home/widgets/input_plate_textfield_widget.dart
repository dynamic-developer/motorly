import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/style/colors.dart';
import '../../../shared/style/text_styles.dart';

class InputPlateTextFieldWidget extends StatefulWidget {
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
  final void Function(String) onFieldSubmitted;

  final void Function(String) onValidator;

  InputPlateTextFieldWidget({
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
    @required this.onFieldSubmitted,
  });

  @override
  _InputPlateTextFieldWidgetState createState() =>
      _InputPlateTextFieldWidgetState();
}

class _InputPlateTextFieldWidgetState extends State<InputPlateTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.initialValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          textAlign: TextAlign.center,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          keyboardType: widget?.keyboardType,
          inputFormatters: [LengthLimitingTextInputFormatter(9)],
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
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
            // labelText: widget.hintText,
            hintText: widget.hintText,
            filled: true,
            fillColor: AppColors.backgroundCard,

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
              padding: const EdgeInsets.all(13.0).copyWith(left: 15),
              child: SvgPicture.asset(
                'assets/icon/enter-plate-car.svg',
                color: AppColors.backgroundWidget,
                height: 7,
              ),
            ),
            suffixIcon: widget?.suffixIcon,
          ),
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
