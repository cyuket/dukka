import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukka/core/errors/errors.dart';
import 'package:dukka/core/errors/network_info.dart';
import 'package:dukka/feature/dashboard/data/model/expense_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class DashboardRemoteDataSource {
  Future<bool> addExpenses({required ExpensesModel data});
  Stream<List<ExpensesModel>> getExpensesList();
}

@LazySingleton(as: DashboardRemoteDataSource)
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  DashboardRemoteDataSourceImpl({
    required this.networkInfo,
  });

  FirebaseAuth auth = FirebaseAuth.instance;

  final NetworkInfo networkInfo;

  CollectionReference get expenseCollection =>
      FirebaseFirestore.instance.collection('expense');

  @override
  Future<bool> addExpenses({required ExpensesModel data}) async {
    if (await networkInfo.isConnected) {
      await expenseCollection.doc(data.id).set(
            data.toJson(),
          );
      return true;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Stream<List<ExpensesModel>> getExpensesList() {
    final userId = auth.currentUser!.uid;
    final transformer =
        StreamTransformer<QuerySnapshot, List<ExpensesModel>>.fromHandlers(
      handleData:
          (QuerySnapshot snaps, EventSink<List<ExpensesModel>> out) async {
        final list = <ExpensesModel>[];
        for (final snap in snaps.docs) {
          final debtor = ExpensesModel.fromJson(snap.data());
          list.add(debtor);
        }
        out.add(list);
      },
    );
    return expenseCollection
        .where('user', isEqualTo: userId)
        .snapshots()
        .transform(transformer);
  }
}
