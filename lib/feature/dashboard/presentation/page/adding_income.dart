import 'dart:async';

import 'package:dukka/app/shared/colors.dart';
import 'package:dukka/app/shared/fonts.dart';
import 'package:dukka/app/view/base_view.dart';
import 'package:dukka/app/widget/busy_button.dart';
import 'package:dukka/app/widget/input_field.dart';
import 'package:dukka/core/utils/custom_form_validation.dart';
import 'package:dukka/feature/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddingIncomePage extends StatefulWidget {
  const AddingIncomePage({Key? key}) : super(key: key);

  @override
  State<AddingIncomePage> createState() => _AddingIncomePageState();
}

class _AddingIncomePageState extends State<AddingIncomePage> {
  final ValueNotifier<bool> _canSubmit = ValueNotifier(false);

  final _amountController = TextEditingController();
  final _titleController = TextEditingController();

  late StreamController<String> amountStreamController;
  late StreamController<String> titleStreamController;

  final _amountFocus = FocusNode();
  final _titleFocus = FocusNode();

  @override
  void initState() {
    amountStreamController = StreamController<String>.broadcast();
    titleStreamController = StreamController<String>.broadcast();

    _amountController.addListener(() {
      amountStreamController.sink.add(_amountController.text.trim());
      // validateInputs();
    });
    _titleController.addListener(() {
      titleStreamController.sink.add(_titleController.text.trim());
      validateInputs();
    });
    super.initState();
  }

  void validateInputs() {
    var canSumit = true;

    final amountError = CustomFormValidation.errorMessage(
      _titleController.text.trim(),
      'First name is required',
    );
    final titleError = CustomFormValidation.errorMessage(
      _titleController.text.trim(),
      'Last name is required',
    );

    if (amountError != '' || titleError != '') {
      canSumit = false;
    }
    _canSubmit.value = canSumit;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardProvider>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.greenColor,
          appBar: AppBar(
            backgroundColor: AppColors.greenColor,
            elevation: 0,
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(
                    'Add Expenses',
                    color: AppColors.greenColor,
                    fontSize: 25,
                  ),
                  const Gap(30),
                  TextRegular(
                    'Title',
                    color: AppColors.blackColor70,
                  ),
                  const Gap(10),
                  StreamBuilder<String>(
                    stream: titleStreamController.stream,
                    builder: (context, snapshot) {
                      return InputField(
                        controller: _titleController,
                        placeholder: 'Title',
                        validationMessage: CustomFormValidation.errorMessage(
                          snapshot.data,
                          'Title is required',
                        ),
                        validationColor: CustomFormValidation.getColor(
                          snapshot.data,
                          _titleFocus,
                          CustomFormValidation.errorMessage(
                            snapshot.data,
                            'Title is required',
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  TextRegular(
                    'amount',
                    color: AppColors.blackColor70,
                  ),
                  const Gap(10),
                  StreamBuilder<String>(
                    stream: amountStreamController.stream,
                    builder: (context, snapshot) {
                      return InputField(
                        controller: _amountController,
                        placeholder: 'Enter Amount',
                        textInputType: TextInputType.number,
                        validationMessage: CustomFormValidation.errorMessage(
                          snapshot.data,
                          'amount is required',
                        ),
                        validationColor: CustomFormValidation.getColor(
                          snapshot.data,
                          _amountFocus,
                          CustomFormValidation.errorMessage(
                            snapshot.data,
                            'amount is required',
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(50),
                  ValueListenableBuilder<bool>(
                    valueListenable: _canSubmit,
                    builder: (context, canSubmit, child) {
                      return BusyButton(
                        title: 'Add',
                        disabled: !canSubmit,
                        color: AppColors.greenColor,
                        busy: model.busy,
                        onPressed: () async {
                          await model.addExpense(
                            type: 'income',
                            title: _titleController.text.trim(),
                            reason: '',
                            amount: int.parse(_amountController.text.trim()),
                            context: context,
                          );
                        },
                      );
                    },
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
