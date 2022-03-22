import 'package:dartz/dartz.dart';
import 'package:dukka/core/errors/errors.dart';
import 'package:dukka/feature/auth/data/data_sources/user_data_sources.dart';
import 'package:dukka/feature/auth/data/model/user_model.dart';
import 'package:dukka/feature/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
  });
  final UserRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, UserModel>> create({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.register(
        email: email,
        name: name,
        password: password,
      );
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
  Future<Either<Failure, UserModel>> login(
      {required String email, required String password}) async {
    try {
      final response =
          await remoteDataSource.login(email: email, password: password);
      return Right(response);
    } catch (e) {
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }

      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
