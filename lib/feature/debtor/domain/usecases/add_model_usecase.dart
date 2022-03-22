import 'package:dartz/dartz.dart';
import 'package:dukka/core/errors/errors.dart';
import 'package:dukka/core/usecase/usecase.dart';
import 'package:dukka/feature/debtor/data/model/debtor_model.dart';
import 'package:dukka/feature/debtor/domain/repository/debtor_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddDebtorUseCase extends UseCase<bool, DebtorModel> {
  AddDebtorUseCase({
    required this.dataRepository,
  });

  final DebtorRepository dataRepository;

  @override
  Future<Either<Failure, bool>> call(DebtorModel params) {
    return dataRepository.addDebtor(model: params);
  }
}
