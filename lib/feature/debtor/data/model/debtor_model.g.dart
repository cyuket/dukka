// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debtor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebtorModel _$DebtorModelFromJson(Map<String, dynamic> json) => DebtorModel(
      amount: json['amount'] as int,
      id: json['id'] as String,
      dueDate: json['dueDate'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      isPaid: json['isPaid'] as bool,
      user: json['user'] as String,
    );

Map<String, dynamic> _$DebtorModelToJson(DebtorModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'dueDate': instance.dueDate,
      'amount': instance.amount,
      'id': instance.id,
      'user': instance.user,
      'isPaid': instance.isPaid,
    };
