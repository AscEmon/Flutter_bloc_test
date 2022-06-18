import 'package:flutter/material.dart';

class GlobalTextFormField extends StatelessWidget {
  bool obscureText = false;
  FocusNode? focusNode;
  TextInputType? textInputType = TextInputType.text;
  TextEditingController? controller;
  String? Function(String?)? validator;
  Widget? suffixIcon;
  Widget? prefixIcon;
  int? maxlength;
  AutovalidateMode? autovalidateMode;
  bool readOnly = false;
  Color? fillColor;
  String? hintText;
  TextStyle? hintStyle;
  TextStyle? style;
  int? line;
  String? initialValue;

  GlobalTextFormField({
    Key? key,
    this.obscureText = false,
    this.focusNode,
    this.textInputType,
    this.controller,
    this.validator,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.maxlength,
    this.initialValue,
    this.autovalidateMode,
    this.readOnly = false,
    this.hintText,
    this.hintStyle = const TextStyle(
      color: Color(0xff808790),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    this.line,
    this.style = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      focusNode: focusNode,
      maxLines: line,
      style: style,
      autovalidateMode: autovalidateMode,
      obscureText: obscureText,
      obscuringCharacter: '*',
      controller: controller,
      cursorColor: Colors.black,
      keyboardType: textInputType,
      maxLength: maxlength,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        filled: true,
        counterText: "",
        fillColor: fillColor ?? const Color(0xffededed),
        suffixIcon: suffixIcon,
        hintStyle: hintStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      validator: validator,
      readOnly: readOnly,
    );
  }
}
