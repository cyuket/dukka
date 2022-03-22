import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dukka/app/shared/colors.dart';
import 'package:dukka/app/shared/fonts.dart';
import 'package:dukka/app/view/base_view.dart';
import 'package:dukka/app/widget/busy_button.dart';
import 'package:dukka/app/widget/input_field.dart';
import 'package:dukka/core/utils/custom_form_validation.dart';
import 'package:dukka/feature/debtor/presentation/provider/debtor_provider.dart';
import 'package:dukka/feature/debtor/presentation/widgets/contact_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AddDebtorPage extends StatefulWidget {
  const AddDebtorPage({Key? key}) : super(key: key);

  @override
  State<AddDebtorPage> createState() => _AddDebtorPageState();
}

class _AddDebtorPageState extends State<AddDebtorPage> {
  final dateFormat = DateFormat('yyyy-MM-dd');
  final ValueNotifier<bool> _canSubmit = ValueNotifier(false);

  final ValueNotifier<DateTime?> dueDate = ValueNotifier(null);
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  late StreamController<String> firstnameStreamController;
  late StreamController<String> lastnameStreamController;
  late StreamController<String> phoneStreamController;
  late StreamController<String> amountStreamController;
  final _firstnameFocus = FocusNode();
  final _lastnameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _amountFocus = FocusNode();

  @override
  void initState() {
    phoneStreamController = StreamController<String>.broadcast();
    amountStreamController = StreamController<String>.broadcast();
    firstnameStreamController = StreamController<String>.broadcast();
    lastnameStreamController = StreamController<String>.broadcast();

    _firstNameController.addListener(() {
      firstnameStreamController.sink.add(_firstNameController.text.trim());
      validateInputs();
    });
    _lastNameController.addListener(() {
      lastnameStreamController.sink.add(_lastNameController.text.trim());
      validateInputs();
    });

    _phoneController.addListener(() {
      phoneStreamController.sink.add(_phoneController.text.trim());
      validateInputs();
    });
    _amountController.addListener(() {
      amountStreamController.sink.add(_amountController.text.trim());
      validateInputs();
    });
    super.initState();
  }

  void validateInputs() {
    var canSumit = true;

    final firstnameError = CustomFormValidation.errorMessage(
      _firstNameController.text.trim(),
      'First name is required',
    );
    final lastnameError = CustomFormValidation.errorMessage(
      _lastNameController.text.trim(),
      'Last name is required',
    );
    final phoneError = CustomFormValidation.errorPhoneNumber2(
      _phoneController.text.trim(),
      'phone is required',
    );
    final amountError = CustomFormValidation.errorMessage(
      _amountController.text.trim(),
      'Password is required',
    );

    if (firstnameError != '' ||
        lastnameError != '' ||
        amountError != '' ||
        phoneError != '' ||
        dueDate.value == null) {
      canSumit = false;
    }
    _canSubmit.value = canSumit;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DebotorProvider>(
      onModelReady: (p0) => p0.getContacts(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.yellowColor,
          appBar: AppBar(
            backgroundColor: AppColors.yellowColor,
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
                    'Add Debtor',
                    color: AppColors.yellowColor,
                    fontSize: 25,
                  ),
                  const Gap(30),
                  TextRegular(
                    'First Name',
                    color: AppColors.blackColor70,
                  ),
                  const Gap(10),
                  StreamBuilder<String>(
                    stream: firstnameStreamController.stream,
                    builder: (context, snapshot) {
                      return InputField(
                        controller: _firstNameController,
                        placeholder: 'First name',
                        validationMessage: CustomFormValidation.errorMessage(
                          snapshot.data,
                          'First name is required',
                        ),
                        validationColor: CustomFormValidation.getColor(
                          snapshot.data,
                          _firstnameFocus,
                          CustomFormValidation.errorMessage(
                            snapshot.data,
                            'First name is required',
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  TextRegular(
                    'Last Name',
                    color: AppColors.blackColor70,
                  ),
                  const Gap(10),
                  StreamBuilder<String>(
                    stream: lastnameStreamController.stream,
                    builder: (context, snapshot) {
                      return InputField(
                        controller: _lastNameController,
                        placeholder: 'Last name',
                        validationMessage: CustomFormValidation.errorMessage(
                          snapshot.data,
                          'last name is required',
                        ),
                        validationColor: CustomFormValidation.getColor(
                          snapshot.data,
                          _lastnameFocus,
                          CustomFormValidation.errorMessage(
                            snapshot.data,
                            'Last name is required',
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  TextRegular(
                    'Phone Number',
                    color: AppColors.blackColor70,
                  ),
                  const Gap(10),
                  StreamBuilder<String>(
                    stream: phoneStreamController.stream,
                    builder: (context, snapshot) {
                      return InputField(
                        controller: _phoneController,
                        placeholder: 'Phone number',
                        textInputType: TextInputType.phone,
                        suffix: IconButton(
                          icon: const Icon(Icons.contact_phone),
                          onPressed: () {
                            ContactBottomModal.show(
                              context: context,
                              contacts: model.contacts,
                              onSelect: (contact) {
                                _phoneController.text =
                                    contact.phones!.first.value!;
                              },
                            );
                          },
                        ),
                        validationMessage:
                            CustomFormValidation.errorPhoneNumber2(
                          snapshot.data,
                          'phone number is required',
                        ),
                        validationColor: CustomFormValidation.getColor(
                          snapshot.data,
                          _phoneFocus,
                          CustomFormValidation.errorPhoneNumber2(
                            snapshot.data,
                            'phone number is required',
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  TextRegular(
                    'Amount borrowed',
                    color: AppColors.blackColor70,
                  ),
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
                  const Gap(10),
                  TextRegular(
                    'Date of repayment',
                    color: AppColors.blackColor70,
                  ),
                  const Gap(10),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.blackColor25,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DateTimeField(
                      format: dateFormat,
                      decoration: const InputDecoration(
                        hintText: 'Select Date of game',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.blackColor70,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      onChanged: (date) {
                        dueDate.value = date;
                        validateInputs();
                      },
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          routeSettings: const RouteSettings(
                            name: 'add/game',
                          ),
                          firstDate: DateTime.now(),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(3000),
                        );
                      },
                    ),
                  ),
                  const Gap(50),
                  ValueListenableBuilder<bool>(
                    valueListenable: _canSubmit,
                    builder: (context, canSubmit, child) {
                      return BusyButton(
                        title: 'Add',
                        disabled: !canSubmit,
                        color: AppColors.yellowColor,
                        busy: model.busy,
                        onPressed: () async {
                          await model.addDebtor(
                            firstName: _firstNameController.text.trim(),
                            lastName: _lastNameController.text.trim(),
                            phoneNumber: _phoneController.text.trim(),
                            amount: int.parse(_amountController.text.trim()),
                            dueDate: dueDate.value!.toIso8601String(),
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
