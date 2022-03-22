import 'package:freezed_annotation/freezed_annotation.dart';

part 'debtor_model.g.dart';

@JsonSerializable()
class DebtorModel {
  DebtorModel(
      {required this.amount,
      required this.id,
      required this.dueDate,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.isPaid,
      required this.user});
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String dueDate;
  final int amount;
  final String id;
  final String user;
  final bool isPaid;
  factory DebtorModel.fromJson(Map<String, dynamic> json) =>
      _$DebtorModelFromJson(json);
  Map<String, dynamic> toJson() => _$DebtorModelToJson(this);
}

class DebtorList {
  DebtorList({
    required this.list,
  });
  final List<DebtorModel> list;

  factory DebtorList.fromData(List<Map<String, dynamic>> data) {
    return DebtorList(
      list: data
          .map(
            (i) => DebtorModel.fromJson(i),
          )
          .toList(),
    );
  }
}
