import 'package:dukka/app/shared/custom_circukar_progress_bar.dart';
import 'package:flutter/material.dart';

class ThirdPartyLoader extends StatelessWidget {
  const ThirdPartyLoader({
    Key? key,
    this.color,
    this.size,
    this.strokeWidth,
  }) : super(key: key);

  final Color? color;
  final double? size, strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 20,
      width: size ?? 20,
      child: CustomCircularProgressIndicator(
        color: color,
      ),
    );
  }
}
