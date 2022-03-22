// ignore_for_file: join_return_with_assignment, use_build_context_synchronously

import 'package:dukka/app/shared/flushbar_notification.dart';
import 'package:dukka/app/view/view_model/base_view_model.dart';
import 'package:dukka/core/errors/failure.dart';
import 'package:dukka/core/injections/injections.dart';
import 'package:dukka/core/local_data/local_data_storage.dart';
import 'package:dukka/core/navigators/navigators.dart';
import 'package:dukka/feature/auth/data/model/user_model.dart';
import 'package:dukka/feature/auth/domain/usecases/login_usecase.dart';
import 'package:dukka/feature/auth/domain/usecases/register_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@lazySingleton
class AuthProvider extends BaseModel {
  AuthProvider({
    required this.loginUserCase,
    required this.registerUseCase,
  });
  final LoginUserCase loginUserCase;
  final RegisterUseCase registerUseCase;
  final LocalAuthentication biometryAuth = LocalAuthentication();
  UserModel? _user;
  UserModel? get user => _user;

  Future<bool> loginUserWithBiometric(BuildContext context) async {
    setBusy(value: true);
    final canAuth = await checkBiometrics(context);
    if (canAuth) {
      final authenticated = await authenticateWithBiometry(context);

      if (authenticated) {
        final storage = sl<LocalDataStorage>();
        final email = await storage.getEmail();
        final password = await storage.getPassword();
        await login(
          email: email!,
          password: password!,
          context: context,
        );

        setBusy(value: false);
        return true;
      } else {
        setBusy(value: false);

        return false;
      }
    } else {
      setBusy(value: false);
      return false;
    }
  }

  Future<bool> authenticateWithBiometry(BuildContext context) async {
    var authenticated = false;
    try {
      authenticated = await biometryAuth.authenticate(
        localizedReason: 'Dukka biometric login',
        biometricOnly: true,
        stickyAuth: true,
      );

      return authenticated;
    } on PlatformException {
      await FlushBarNotification.showError(
        context: context,
        message: 'Authentication failed',
      );
      return false;
    }
  }

  Future<bool> checkBiometrics(BuildContext context) async {
    var canCheckBiometrics = false;
    try {
      canCheckBiometrics = await biometryAuth.canCheckBiometrics;
      return canCheckBiometrics;
    } on PlatformException {
      canCheckBiometrics = canCheckBiometrics;
      await FlushBarNotification.showError(
        context: context,
        message: 'Your device does not support biometric login',
      );
      return canCheckBiometrics;
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    setBusy(value: true);
    final result = await loginUserCase(
      LoginUserCaseParam(email: email, password: password),
    );
    await result.fold(
      (l) {
        FlushBarNotification.showError(
          context: context,
          message: FailureToMessage.mapFailureToMessage(l),
        );
        setBusy(value: false);
      },
      (r) async {
        _user = r;
        final storage = sl<LocalDataStorage>();
        await storage.saveEmail(email);
        await storage.savePassword(password);
        setBusy(value: false);
        await Navigator.pushNamed(context, Routes.dashboardScreen);
      },
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    setBusy(value: true);
    final result = await registerUseCase(
      RegisterUseCaseParam(
        email: email,
        password: password,
        name: name,
      ),
    );
    await result.fold(
      (l) {
        FlushBarNotification.showError(
          context: context,
          message: FailureToMessage.mapFailureToMessage(l),
        );
        setBusy(value: false);
      },
      (r) async {
        final storage = sl<LocalDataStorage>();
        await storage.saveEmail(email);
        await storage.savePassword(password);
        _user = r;

        setBusy(value: false);
        await Navigator.pushNamed(context, Routes.dashboardScreen);
      },
    );
  }
}
