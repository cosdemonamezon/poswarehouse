// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
      json['id'] as int,
      json['name'] as String?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      json['deleted_at'] as String?,
    );

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'deleted_at': instance.deleted_at,
    };
