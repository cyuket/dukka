import 'package:json_annotation/json_annotation.dart';

part 'expense_model.g.dart';

@JsonSerializable()
class ExpensesModel {
  ExpensesModel({
    required this.date,
    required this.id,
    required this.title,
    required this.type,
    required this.user,
    this.reason,
    required this.amount,
  });
  final String title;
  final String id;
  final String date;
  final String type;
  final String user;
  final String? reason;
  final int amount;

  factory ExpensesModel.fromJson(Map<String, dynamic> json) =>
      _$ExpensesModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExpensesModelToJson(this);
}
