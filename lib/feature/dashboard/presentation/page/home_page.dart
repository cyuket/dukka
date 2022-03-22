import 'package:dukka/app/shared/colors.dart';
import 'package:dukka/app/shared/fonts.dart';
import 'package:dukka/app/view/base_view.dart';
import 'package:dukka/feature/dashboard/data/model/expense_model.dart';
import 'package:dukka/feature/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardProvider>(
      builder: (context, model, child) {
        return StreamBuilder<List<ExpensesModel>>(
          stream: model.getAllExpenses(),
          builder: (context, snapshot) {
            final data = snapshot.data;
            var balance = 0;
            if (data != null) {
              for (final item in data) {
                if (item.type == 'income') {
                  balance = balance + item.amount;
                } else {
                  balance = balance - item.amount;
                }
              }
            }
            final amount = NumberFormat.currency(
              locale: 'en_US',
              symbol: '',
              decimalDigits: 0,
            ).format(balance);
            return Scaffold(
              backgroundColor: AppColors.blueColor,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBold(
                          'Hey, ${model.user!.name}',
                          fontSize: 30,
                          color: Colors.white,
                        ),
                        const Gap(10),
                        TextRegular(
                          'How are you doing',
                          color: AppColors.blackColor25,
                        ),
                        const Gap(20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextBold('Your Balance'),
                                    TextRegular(
                                      'Today',
                                      color: AppColors.blackColor50,
                                    ),
                                    const Gap(10),
                                    TextBold(
                                      'N$amount',
                                      fontSize: 25,
                                      color: AppColors.blueColor,
                                    )
                                  ],
                                ),
                              ),
                              const Gap(20),
                              const Icon(
                                Icons.monetization_on_outlined,
                                size: 50,
                                color: AppColors.blueColor,
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        if (data == null)
                          const SizedBox.shrink()
                        else
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextBold('Your Expenses'),
                                const Gap(20),
                                ...List.generate(data.length, (index) {
                                  final item = data[index];
                                  final amount = NumberFormat.currency(
                                    locale: 'en_US',
                                    symbol: '',
                                    decimalDigits: 0,
                                  ).format(item.amount);
                                  final date = DateFormat().add_yMMMMd().format(
                                        DateTime.parse(item.date),
                                      );
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                item.type == 'income'
                                                    ? AppColors.greenColor10
                                                    : AppColors.redColor10,
                                            child: TextBold(
                                              item.type == 'income' ? '+' : '-',
                                              color: item.type == 'income'
                                                  ? AppColors.greenColor
                                                  : AppColors.redColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const Gap(20),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextBold(
                                                  item.title,
                                                ),
                                                const Gap(5),
                                                Row(
                                                  children: [
                                                    const Gap(10),
                                                    TextRegular(
                                                      date,
                                                      color: AppColors
                                                          .blackColor70,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          TextRegular(
                                            item.type == 'income'
                                                ? 'N$amount'
                                                : '-N$amount',
                                            color: item.type == 'income'
                                                ? AppColors.greenColor
                                                : AppColors.redColor,
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Divider(),
                                      )
                                    ],
                                  );
                                })
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
