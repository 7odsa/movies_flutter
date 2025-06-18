import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/app_style.dart';
import 'package:movies_flutter/_core/constants/colors.dart';

class CustomTexFiled extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  // final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool isPassword;

  const CustomTexFiled({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.controller,
    this.isPassword = false,
    this.hintText,
  });

  @override
  State<CustomTexFiled> createState() => _CustomTexFiledState();
}

class _CustomTexFiledState extends State<CustomTexFiled> {
  final OutlineInputBorder defaultBorder = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(color: ColorsApp.gray),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: AppStyle.textTheme.labelMedium,
        prefixIcon: widget.prefixIcon,
        filled: true,
        fillColor: ColorsApp.gray,
        border: defaultBorder,
        enabledBorder: defaultBorder,
        focusedBorder: defaultBorder,
      ),
    );
  }
}
