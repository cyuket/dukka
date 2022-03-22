import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukka/core/errors/errors.dart';
import 'package:dukka/core/errors/network_info.dart';
import 'package:dukka/feature/debtor/data/model/debtor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class DebtorRemoteDataSource {
  Future<bool> addDebtor({required DebtorModel model});
  Stream<List<DebtorModel>> getDebtorList();
}

@LazySingleton(as: DebtorRemoteDataSource)
class DebtorRemoteDataSourceImpl implements DebtorRemoteDataSource {
  DebtorRemoteDataSourceImpl({
    required this.networkInfo,
  });

  FirebaseAuth auth = FirebaseAuth.instance;

  final NetworkInfo networkInfo;

  CollectionReference get debtorsCollection =>
      FirebaseFirestore.instance.collection('debtors');
  @override
  Future<bool> addDebtor({required DebtorModel model}) async {
    if (await networkInfo.isConnected) {
      await debtorsCollection.doc(model.id).set(
            model.toJson(),
          );
      return true;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Stream<List<DebtorModel>> getDebtorList() {
    final userId = auth.currentUser!.uid;
    final transformer =
        StreamTransformer<QuerySnapshot, List<DebtorModel>>.fromHandlers(
      handleData:
          (QuerySnapshot snaps, EventSink<List<DebtorModel>> out) async {
        final list = <DebtorModel>[];
        for (final snap in snaps.docs) {
          final debtor = DebtorModel.fromJson(snap.data());
          list.add(debtor);
        }
        out.add(list);
      },
    );
    return debtorsCollection
        .where('user', isEqualTo: userId)
        .snapshots()
        .transform(transformer);
  }
}
