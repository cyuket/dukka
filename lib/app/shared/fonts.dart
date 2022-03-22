import 'package:dukka/app/shared/colors.dart';
import 'package:flutter/material.dart';

/// Base text with black color and letter spacing set
class AppTextBase extends StatelessWidget {
  const AppTextBase(
    this.text, {
    this.style,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.visible,
    this.maxLines,
    Key? key,
  }) : super(key: key);
  final String? text;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    assert(text != null, 'test can not be null');
    return Text(
      text ?? '',
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.blackColor,
      ).merge(style),
      key: key,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

/// Main black bold text
class AppTextBold extends AppTextBase {
  AppTextBold(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) : super(
          text,
          key: key,
          style: const TextStyle(
            fontFamily: 'DMSans-Bold',
            fontWeight: FontWeight.bold,
          ).merge(style),
          textAlign: textAlign ?? TextAlign.left,
          overflow: overflow ?? TextOverflow.visible,
          maxLines: maxLines,
        );
}

class AppTextRegular extends AppTextBase {
  AppTextRegular(
    String text, {
    TextStyle? style,
    TextAlign textAlign = TextAlign.left,
    TextOverflow overflow = TextOverflow.visible,
    int? maxLines,
    Key? key,
  }) : super(
          text,
          style: const TextStyle(
            fontFamily: 'DMSans-Regular',
            fontWeight: FontWeight.normal,
          ).merge(style),
          textAlign: textAlign,
          overflow: overflow,
          key: key,
          maxLines: maxLines,
        );
}

class TextRegular extends AppTextRegular {
  TextRegular(
    String text, {
    TextStyle? style,
    Color color = Colors.black,
    double fontSize = 15,
    TextAlign textAlign = TextAlign.left,
    TextOverflow overflow = TextOverflow.visible,
    int? maxLines,
    Key? key,
  }) : super(
          text,
          overflow: overflow,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
          ).merge(style),
          textAlign: textAlign,
          key: key,
          maxLines: maxLines,
        );
}

class TextBold extends AppTextBold {
  TextBold(
    String text, {
    TextStyle? style,
    Color color = Colors.black,
    double fontSize = 20,
    TextAlign textAlign = TextAlign.left,
    TextOverflow overflow = TextOverflow.visible,
    int maxLines = 2,
    Key? key,
  }) : super(
          text,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: FontWeight.bold,
          ).merge(style),
          textAlign: textAlign,
          key: key,
        );
}

TextStyle textSpanStyle({Color? color, double? fontSize}) => TextStyle(
      fontFamily: 'Inter-Regular',
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.blackColor70,
      fontSize: fontSize ?? 12,
      height: 1.5,
    );
