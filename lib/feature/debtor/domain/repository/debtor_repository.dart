import 'package:dartz/dartz.dart';
import 'package:dukka/core/errors/errors.dart';
import 'package:dukka/feature/debtor/data/model/debtor_model.dart';

abstract class DebtorRepository {
  Future<Either<Failure, bool>> addDebtor({required DebtorModel model});
  Stream<List<DebtorModel>> getDebtor();
}
