import 'package:dartz/dartz.dart';
import 'package:dukka/core/errors/errors.dart';
import 'package:dukka/feature/debtor/data/data_sources/debtor_data_sources.dart';
import 'package:dukka/feature/debtor/data/model/debtor_model.dart';
import 'package:dukka/feature/debtor/domain/repository/debtor_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DebtorRepository)
class DebtorRepositoryImpl extends DebtorRepository {
  DebtorRepositoryImpl({
    required this.remoteDataSource,
  });
  final DebtorRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, bool>> addDebtor({required DebtorModel model}) async {
    try {
      final response = await remoteDataSource.addDebtor(model: model);
      return Right(response);
    } catch (e) {
      print(e);
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }

      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<DebtorModel>> getDebtor() {
    return remoteDataSource.getDebtorList();
  }
}
