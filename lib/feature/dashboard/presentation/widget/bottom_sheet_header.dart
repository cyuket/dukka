import 'package:dukka/app/shared/colors.dart';
import 'package:dukka/app/shared/fonts.dart';
import 'package:dukka/app/widget/touchables/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.title,
    this.leading,
  }) : super(key: key);

  final String title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.blackColor25,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        const Gap(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (leading != null) leading!,
            TextRegular(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            TouchableOpacity(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.blackColor10,
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.blackColor70,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
