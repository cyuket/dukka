import 'package:dukka/app/shared/fonts.dart';
import 'package:flutter/material.dart';

class NoteText extends StatelessWidget {
  const NoteText(
    this.text, {
    this.textAlign = TextAlign.left,
    this.color,
    Key? key,
  }) : super(key: key);

  final String text;
  final TextAlign textAlign;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextRegular(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: color ?? Colors.grey[600],
      ),
    );
  }
}
