import 'dart:ui';

import 'package:dukka/app/shared/colors.dart';
import 'package:dukka/app/shared/fonts.dart';
import 'package:dukka/app/widget/touchables/touchable_opacity.dart';
import 'package:dukka/core/navigators/routes.dart';
import 'package:dukka/feature/dashboard/presentation/widget/bottom_sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreateBudgetBootom extends StatelessWidget {
  const CreateBudgetBootom({Key? key}) : super(key: key);
  static Future<String?> show({
    required BuildContext context,
  }) async {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      routeSettings: const RouteSettings(name: '/add/bottomsheet'),
      builder: (context) {
        return const CreateBudgetBootom();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 1.5,
        sigmaY: 1.5,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            const HeaderWidget(title: 'Add Budget'),
            const Gap(20),
            TouchableOpacity(
              onTap: () => Navigator.pushNamed(context, Routes.addDebtScreen),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.yellowColor10,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    TextBold(
                      'Add Debt',
                      color: AppColors.yellowColor,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(30),
            TouchableOpacity(
              onTap: () =>
                  Navigator.pushNamed(context, Routes.addExpenseScreen),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.redColor10,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    TextBold(
                      'Add Expenses',
                      color: AppColors.redColor,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(30),
            TouchableOpacity(
              onTap: () => Navigator.pushNamed(context, Routes.addIncomeScreen),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.greenColor10,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    TextBold(
                      'Add Income',
                      color: AppColors.greenColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
