import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final Widget? icon;
  final void Function() onClick;
  final TextStyle textStyle;
  final double elevation;
  final double horizontal;
  final double vertical;

  const CustomElevatedButton({
    super.key,
    this.backgroundColor = Colors.yellow,
    this.icon,
    required this.onClick,
    required this.text,
    required this.textStyle,
    this.elevation = 1,
    required this.horizontal,
    required this.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: backgroundColor),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
