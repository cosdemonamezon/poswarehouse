// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryProduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryProduct _$CategoryProductFromJson(Map<String, dynamic> json) =>
    CategoryProduct(
      json['id'] as int,
      json['name'] as String?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      json['deleted_at'] as String?,
    );

Map<String, dynamic> _$CategoryProductToJson(CategoryProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'deleted_at': instance.deleted_at,
    };
