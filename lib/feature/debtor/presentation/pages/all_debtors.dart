import 'package:dukka/app/shared/colors.dart';
import 'package:dukka/app/shared/fonts.dart';
import 'package:dukka/app/view/base_view.dart';
import 'package:dukka/app/widget/busy_button.dart';
import 'package:dukka/feature/debtor/data/model/debtor_model.dart';
import 'package:dukka/feature/debtor/presentation/provider/debtor_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AllDebtors extends StatefulWidget {
  const AllDebtors({Key? key}) : super(key: key);

  @override
  State<AllDebtors> createState() => _AllDebtorsState();
}

class _AllDebtorsState extends State<AllDebtors> {
  @override
  Widget build(BuildContext context) {
    return BaseView<DebotorProvider>(
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(
                    'Debtors',
                    fontSize: 35,
                  ),
                  const Gap(32),
                  Expanded(
                    child: StreamBuilder<List<DebtorModel>>(
                      stream: model.getDebtors(),
                      builder: (context, snapshot) {
                        final data = snapshot.data;
                        return data == null
                            ? const SizedBox.shrink()
                            : ListView.separated(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final debtor = data[index];
                                  final amount = NumberFormat.currency(
                                    locale: 'en_US',
                                    symbol: '',
                                    decimalDigits: 0,
                                  ).format(debtor.amount);
                                  final date = DateFormat().add_yMMMMd().format(
                                        DateTime.parse(debtor.dueDate),
                                      );
                                  return Container(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              AppColors.blueColor10,
                                          child: TextBold(
                                            '${debtor.firstName[0]}${debtor.lastName[0]}',
                                            color: AppColors.blueColor,
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
                                                  '${debtor.firstName} ${debtor.lastName}'),
                                              const Gap(5),
                                              Row(
                                                children: [
                                                  TextRegular(
                                                    'N$amount',
                                                    color: AppColors.redColor,
                                                  ),
                                                  const Gap(10),
                                                  TextRegular(
                                                    date,
                                                    color:
                                                        AppColors.blackColor70,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: BusyButton(
                                            isSmall: true,
                                            onPressed: () {},
                                            title: 'Remind',
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (_, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Column(
                                      children: const [
                                        Gap(20),
                                        Divider(
                                          color: AppColors.blackColor10,
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
