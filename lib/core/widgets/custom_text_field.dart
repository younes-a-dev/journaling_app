import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.hintText,
    this.prefixIcon,
    this.onChangeFunction,
    this.prefix,
    this.autoFocus = false,
    this.maxLine,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final IconData? prefixIcon;
  final void Function(String value)? onChangeFunction;
  final String? prefix;
  final bool autoFocus;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      maxLines: maxLine,
      cursorColor: const Color(0xffffca28),
      autofocus: autoFocus,
      textAlignVertical: TextAlignVertical.bottom,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xffbdbdbd),
      ),
      decoration: InputDecoration(
        // suffix: Text(prefix!,),
        suffixStyle: const TextStyle(color: Color(0xffffca28)),
        suffixText: prefix,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xffbdbdbd)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
              color: Colors.transparent, style: BorderStyle.none),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
              color: Colors.transparent, style: BorderStyle.none),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
              color: Colors.transparent, style: BorderStyle.none),
        ),
        filled: true,
        fillColor: const Color(0xff212121),
      ),
      onChanged: onChangeFunction,
    );
  }
}

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({
    required this.controller,
    required this.textInputType,
    required this.hintText,
    this.maxLine,
    this.autoFocus = false,
    this.validator,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final int? maxLine;
  final bool autoFocus;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: textInputType,
        // textAlign: TextAlign.end,
        textInputAction: TextInputAction.next,
        maxLines: maxLine,
        // focusNode: focusNode,
        cursorColor: const Color(0xffffca28),
        autofocus: autoFocus,
        textAlignVertical: TextAlignVertical.bottom,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Color(0xffbdbdbd),
        ),
        decoration: InputDecoration(
          suffixStyle: const TextStyle(color: Color(0xffffca28)),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xffbdbdbd)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
                color: Colors.transparent, style: BorderStyle.none),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
                color: Colors.transparent, style: BorderStyle.none),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
                color: Colors.transparent, style: BorderStyle.none),
          ),
          filled: true,
          fillColor: const Color(0xff212121),
        ),
        validator: validator);
  }
}
