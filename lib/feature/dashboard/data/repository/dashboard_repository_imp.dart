import 'package:dartz/dartz.dart';
import 'package:dukka/core/errors/error.dart';
import 'package:dukka/core/errors/failure.dart';
import 'package:dukka/feature/dashboard/data/data_sources/dashboard_data_source.dart';
import 'package:dukka/feature/dashboard/data/model/expense_model.dart';
import 'package:dukka/feature/dashboard/domain/repository/dashboard_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DashboardRepository)
class DebtorRepositoryImpl extends DashboardRepository {
  DebtorRepositoryImpl({
    required this.remoteDataSource,
  });
  final DashboardRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, bool>> addExpenses({
    required ExpensesModel data,
  }) async {
    try {
      final response = await remoteDataSource.addExpenses(data: data);
      return Right(response);
    } catch (e) {
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }

      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<ExpensesModel>> getExpensesList() {
    return remoteDataSource.getExpensesList();
  }
}
