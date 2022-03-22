import 'package:dartz/dartz.dart';
import 'package:dukka/core/errors/errors.dart';
import 'package:dukka/feature/dashboard/data/model/expense_model.dart';

abstract class DashboardRepository {
  Future<Either<Failure, bool>> addExpenses({required ExpensesModel data});
  Stream<List<ExpensesModel>> getExpensesList();
}
