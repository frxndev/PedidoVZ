import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

TextFieldProps textFieldProps({
  String? hintText,
  TextInputType? keyboardType,
  bool obscureText = false,
  int minLines = 1,
  int maxLength = 1,
}) {
  return TextFieldProps(
    obscureText: obscureText,
    keyboardType: keyboardType ?? TextInputType.text,
    minLines: minLines,
    maxLines: 8,
    maxLength: maxLength,
    decoration: InputDecoration(
      hintText: hintText,
      filled: true,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
