import 'package:contacts_service/contacts_service.dart';
import 'package:dukka/app/shared/flushbar_notification.dart';
import 'package:dukka/app/view/view_model/base_view_model.dart';
import 'package:dukka/core/errors/errors.dart';
import 'package:dukka/core/injections/locator.dart';
import 'package:dukka/core/navigators/routes.dart';
import 'package:dukka/feature/auth/presentation/provider/auth_provider.dart';
import 'package:dukka/feature/debtor/data/model/debtor_model.dart';
import 'package:dukka/feature/debtor/domain/usecases/add_model_usecase.dart';
import 'package:dukka/feature/debtor/domain/usecases/get_debtor_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class DebotorProvider extends BaseModel {
  DebotorProvider({
    required this.addDebtorUseCase,
    required this.getDebtorsUseCase,
  });
  final AddDebtorUseCase addDebtorUseCase;
  final GetDebtorsUseCase getDebtorsUseCase;
  final user = sl<AuthProvider>().user;

  Stream<List<DebtorModel>> getDebtors() {
    return getDebtorsUseCase();
  }

  List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;
  Future<void> getContacts() async {
    final result = await ContactsService.getContacts();
    _contacts = result;
    notifyListeners();
  }

  Future<void> addDebtor({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required int amount,
    required String dueDate,
    required BuildContext context,
  }) async {
    setBusy(value: true);
    final id = const Uuid().v4();
    final model = DebtorModel(
      amount: amount,
      id: id,
      dueDate: dueDate,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      isPaid: false,
      user: user!.id,
    );
    final result = await addDebtorUseCase(model);
    result.fold(
      (l) {
        FlushBarNotification.showError(
          context: context,
          message: FailureToMessage.mapFailureToMessage(l),
        );
        setBusy(value: false);
      },
      (r) {
        setBusy(value: false);
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.dashboardScreen,
          (route) => false,
        );
      },
    );
  }
}
