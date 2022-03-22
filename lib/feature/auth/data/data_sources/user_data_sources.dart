import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukka/core/errors/errors.dart';
import 'package:dukka/core/errors/network_info.dart';
import 'package:dukka/feature/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register(
      {required String email, required String name, required String password});
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl({
    required this.networkInfo,
  });

  FirebaseAuth auth = FirebaseAuth.instance;

  final NetworkInfo networkInfo;

  CollectionReference get usersCollection =>
      FirebaseFirestore.instance.collection('users');
  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      final authResult = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fetchUser = await usersCollection.doc(authResult.user!.uid).get();
      return UserModel.fromJson(fetchUser.data()!);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<UserModel> register(
      {required String email,
      required String name,
      required String password}) async {
    if (await networkInfo.isConnected) {
      final authResult = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final newUser = UserModel(
        email: email,
        id: authResult.user!.uid,
        name: name,
      );
      await usersCollection.doc(authResult.user!.uid).set(newUser.toJson());
      return newUser;
    } else {
      throw NoInternetException();
    }
  }
}
