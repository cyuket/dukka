import 'package:dukka/app/shared/flushbar_notification.dart';
import 'package:dukka/app/view/view_model/base_view_model.dart';
import 'package:dukka/core/errors/errors.dart';
import 'package:dukka/core/injections/injections.dart';
import 'package:dukka/core/navigators/routes.dart';
import 'package:dukka/feature/auth/presentation/provider/auth_provider.dart';
import 'package:dukka/feature/dashboard/data/model/expense_model.dart';
import 'package:dukka/feature/dashboard/domain/usecases/add_expense_usecase.dart';
import 'package:dukka/feature/dashboard/domain/usecases/get_expense_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class DashboardProvider extends BaseModel {
  DashboardProvider({
    required this.addExpenseUseCase,
    required this.getAllExpenseUseCase,
  });
  final AddExpenseUseCase addExpenseUseCase;
  final GetAllExpenseUseCase getAllExpenseUseCase;

  Stream<List<ExpensesModel>> getAllExpenses() {
    return getAllExpenseUseCase();
  }

  final user = sl<AuthProvider>().user;
  Future<void> addExpense({
    required String title,
    required String reason,
    required int amount,
    required String type,
    required BuildContext context,
  }) async {
    setBusy(value: true);
    final id = const Uuid().v4();
    final model = ExpensesModel(
      date: DateTime.now().toIso8601String(),
      id: id,
      title: title,
      type: type,
      user: user!.id,
      amount: amount,
      reason: reason,
    );
    final result = await addExpenseUseCase(model);
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
