import 'package:dartz/dartz.dart';
import 'package:dukka/core/errors/errors.dart';
import 'package:dukka/core/usecase/usecase.dart';
import 'package:dukka/feature/dashboard/data/model/expense_model.dart';
import 'package:dukka/feature/dashboard/domain/repository/dashboard_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddExpenseUseCase extends UseCase<bool, ExpensesModel> {
  AddExpenseUseCase({
    required this.dataRepository,
  });

  final DashboardRepository dataRepository;

  @override
  Future<Either<Failure, bool>> call(ExpensesModel params) {
    return dataRepository.addExpenses(data: params);
  }
}
