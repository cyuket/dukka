// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpensesModel _$ExpensesModelFromJson(Map<String, dynamic> json) =>
    ExpensesModel(
      date: json['date'] as String,
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      user: json['user'] as String,
      reason: json['reason'] as String?,
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$ExpensesModelToJson(ExpensesModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'date': instance.date,
      'type': instance.type,
      'user': instance.user,
      'reason': instance.reason,
      'amount': instance.amount,
    };
