import 'package:dukka/feature/debtor/data/model/debtor_model.dart';
import 'package:dukka/feature/debtor/domain/repository/debtor_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDebtorsUseCase {
  GetDebtorsUseCase({
    required this.debtorRepository,
  });

  final DebtorRepository debtorRepository;

  Stream<List<DebtorModel>> call() {
    return debtorRepository.getDebtor();
  }
}
