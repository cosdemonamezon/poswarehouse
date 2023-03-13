// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      json['id'] as int?,
      json['name'] as String?,
      json['phone'] as String?,
      json['email'] as String?,
      json['address'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['change'] as int?,
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'change': instance.change,
    };
