// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parades.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parades _$ParadesFromJson(Map<String, dynamic> json) => Parades(
      json['id'] as int,
      json['category_product_id'] as String?,
      json['name'] as String?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['No'] as int?,
    );

Map<String, dynamic> _$ParadesToJson(Parades instance) => <String, dynamic>{
      'id': instance.id,
      'category_product_id': instance.category_product_id,
      'name': instance.name,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'No': instance.No,
    };
