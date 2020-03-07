import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final Function validator;
  final Function onFieldSubmitted;
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Function onChanged;
  final bool isBackgroundLight;
  final int maxLines;
  final int maxLength;

  MyTextFormField(
      {this.validator,
      this.onFieldSubmitted,
      this.focusNode,
      this.controller,
      this.hintText,
      this.obscureText = false,
      this.onChanged,
      this.isBackgroundLight = false,
      this.maxLines = 1,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    Color color = isBackgroundLight ? Colors.grey : Colors.white70;
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      // ignore: missing_return
      onChanged: onChanged,
      onTap: () {},
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      controller: controller,
      style: TextStyle(color: isBackgroundLight ? Colors.black : Colors.white),
      decoration: InputDecoration(
        errorStyle: TextStyle(
            color: Colors.redAccent, fontSize: 13, fontWeight: FontWeight.bold),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              const Radius.circular(30.0),
            ),
            borderSide: BorderSide(color: Colors.deepOrange)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              const Radius.circular(30.0),
            ),
            borderSide: BorderSide(color: Colors.deepOrange)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              const Radius.circular(30.0),
            ),
            borderSide: BorderSide(color: Colors.grey)),
        hintStyle: new TextStyle(color: color.withOpacity(0.5)),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
          borderSide: BorderSide(
            color: isBackgroundLight ? Colors.black54 : Colors.white54,
            width: 1.3,
          ),
        ),
        contentPadding: EdgeInsets.all(20),
      ),
    );
  }
}
