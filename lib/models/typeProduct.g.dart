// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typeProduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeProduct _$TypeProductFromJson(Map<String, dynamic> json) => TypeProduct(
      json['id'] as int,
      json['name'] as String?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      json['created_at'] as String?,
      json['deleted_at'] as String?,
      json['No'] as int?,
      (json['sub_categorys'] as List<dynamic>?)
          ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TypeProductToJson(TypeProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'created_at': instance.created_at,
      'deleted_at': instance.deleted_at,
      'No': instance.No,
      'sub_categorys': instance.sub_categorys,
    };
