import 'package:dukka/feature/dashboard/data/model/expense_model.dart';
import 'package:dukka/feature/dashboard/domain/repository/dashboard_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllExpenseUseCase {
  GetAllExpenseUseCase({
    required this.debtorRepository,
  });

  final DashboardRepository debtorRepository;

  Stream<List<ExpensesModel>> call() {
    return debtorRepository.getExpensesList();
  }
}
