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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late StreamController<String> emailStreamController;
  late StreamController<String> passwordStreamController;
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final ValueNotifier<bool> _canSubmit = ValueNotifier(false);
  @override
  void initState() {
    emailStreamController = StreamController<String>.broadcast();
    passwordStreamController = StreamController<String>.broadcast();

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

    final emailError = CustomFormValidation.errorEmailMessage(
      _emailController.text.trim(),
      'Email is required',
    );
    final passwordError = CustomFormValidation.errorMessage(
      _passwordController.text.trim(),
      'password is required',
    );

    if (emailError != '' || passwordError != '') {
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
            automaticallyImplyLeading: false,
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
                    'Login',
                    color: AppColors.blueColor,
                    fontSize: 25,
                  ),
                  const Gap(30),
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
                        validationMessage:
                            CustomFormValidation.errorEmailMessage(
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
                        placeholder: 'Enter password',
                        validationMessage: CustomFormValidation.errorMessage(
                          snapshot.data,
                          'password is required',
                        ),
                        validationColor: CustomFormValidation.getColor(
                          snapshot.data,
                          _passwordFocus,
                          CustomFormValidation.errorMessage(
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
                        title: 'Login',
                        busy: model.busy,
                        disabled: !canSubmit,
                        onPressed: () async {
                          await model.login(
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context,
                          );
                        },
                      );
                    },
                  ),
                  const Gap(20),
                  TouchableOpacity(
                    onTap: model.busy
                        ? null
                        : () async {
                            await model.loginUserWithBiometric(
                              context,
                            );
                          },
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: model.busy
                                  ? AppColors.blueColor50
                                  : AppColors.blueColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.fingerprint,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                          const Gap(10),
                          TextRegular(
                            'Continue with Biometric',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  const Gap(20),
                  TouchableOpacity(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.signupPage),
                    child: TextRegular(
                      ' Are you new? register',
                      color: AppColors.blackColor70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
