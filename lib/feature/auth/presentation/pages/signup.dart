import 'dart:async';

import 'package:dukka/app/shared/colors.dart';
import 'package:dukka/app/shared/fonts.dart';
import 'package:dukka/app/view/base_view.dart';
import 'package:dukka/app/widget/busy_button.dart';
import 'package:dukka/app/widget/input_field.dart';
import 'package:dukka/app/widget/touchables/touchable_opacity.dart';
import 'package:dukka/core/navigators/routes.dart';
import 'package:dukka/core/utils/custom_form_validation.dart';
import 'package:dukka/feature/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late StreamController<String> nameStreamController;
  late StreamController<String> emailStreamController;
  late StreamController<String> passwordStreamController;
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final ValueNotifier<bool> _canSubmit = ValueNotifier(false);

  @override
  void initState() {
    emailStreamController = StreamController<String>.broadcast();
    nameStreamController = StreamController<String>.broadcast();
    passwordStreamController = StreamController<String>.broadcast();
    _nameController.addListener(() {
      nameStreamController.sink.add(_nameController.text.trim());
      validateInputs();
    });
    _emailController.addListener(() {
      emailStreamController.sink.add(_emailController.text.trim());
      validateInputs();
    });

    _passwordController.addListener(() {
      passwordStreamController.sink.add(_passwordController.text.trim());
      validateInputs();
    });
    super.initState();
  }

  void validateInputs() {
    var canSumit = true;

    final nameError = CustomFormValidation.errorMessage(
      _nameController.text.trim(),
      'Name is required',
    );
    final emailError = CustomFormValidation.errorEmailMessage(
      _emailController.text.trim(),
      'Email is required',
    );
    final passwordError = CustomFormValidation.errorMessagePassword(
      _passwordController.text.trim(),
      'password is required',
    );

    if (nameError != '' || emailError != '' || passwordError != '') {
      canSumit = false;
    }
    _canSubmit.value = canSumit;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthProvider>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.blueColor,
          appBar: AppBar(
            backgroundColor: AppColors.blueColor,
            elevation: 0,
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBold(
                  'Signup',
                  color: AppColors.blueColor,
                  fontSize: 25,
                ),
                const Gap(30),
                TextRegular(
                  'Full Name',
                  color: AppColors.blackColor70,
                ),
                const Gap(10),
                StreamBuilder<String>(
                  stream: nameStreamController.stream,
                  builder: (context, snapshot) {
                    return InputField(
                      controller: _nameController,
                      placeholder: 'Name',
                      validationMessage: CustomFormValidation.errorMessage(
                        snapshot.data,
                        'Name is required',
                      ),
                      validationColor: CustomFormValidation.getColor(
                        snapshot.data,
                        _nameFocus,
                        CustomFormValidation.errorMessage(
                          snapshot.data,
                          'Name is required',
                        ),
                      ),
                    );
                  },
                ),
                const Gap(10),
                TextRegular(
                  'email',
                  color: AppColors.blackColor70,
                ),
                const Gap(10),
                StreamBuilder<String>(
                  stream: emailStreamController.stream,
                  builder: (context, snapshot) {
                    return InputField(
                      controller: _emailController,
                      placeholder: 'Email',
                      validationMessage: CustomFormValidation.errorEmailMessage(
                        snapshot.data,
                        'Email is required',
                      ),
                      validationColor: CustomFormValidation.getColor(
                        snapshot.data,
                        _emailFocus,
                        CustomFormValidation.errorEmailMessage(
                          snapshot.data,
                          'Email is required',
                        ),
                      ),
                    );
                  },
                ),
                const Gap(10),
                TextRegular(
                  'Password',
                  color: AppColors.blackColor70,
                ),
                const Gap(10),
                StreamBuilder<String>(
                  stream: passwordStreamController.stream,
                  builder: (context, snapshot) {
                    return InputField(
                      controller: _passwordController,
                      placeholder: 'password',
                      password: true,
                      validationMessage:
                          CustomFormValidation.errorMessagePassword(
                        snapshot.data,
                        'password is required',
                      ),
                      validationColor: CustomFormValidation.getColor(
                        snapshot.data,
                        _passwordFocus,
                        CustomFormValidation.errorMessagePassword(
                          snapshot.data,
                          'password is required',
                        ),
                      ),
                    );
                  },
                ),
                const Gap(20),
                ValueListenableBuilder<bool>(
                  valueListenable: _canSubmit,
                  builder: (context, canSubmit, child) {
                    return BusyButton(
                      title: 'Signup',
                      busy: model.busy,
                      disabled: !canSubmit,
                      onPressed: () async {
                        await model.register(
                          email: _emailController.text,
                          password: _passwordController.text,
                          name: _nameController.text,
                          context: context,
                        );
                      },
                    );
                  },
                ),
                const Gap(20),
                TouchableOpacity(
                  onTap: () => Navigator.pushNamed(context, Routes.loginPage),
                  child: TextRegular(
                    ' Already have an account? Login',
                    color: AppColors.blackColor70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
