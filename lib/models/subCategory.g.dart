// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      json['id'] as int,
      json['category_product_id'] as int?,
      json['name'] as String?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      json['deleted_at'] as String?,
    );

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_product_id': instance.category_product_id,
      'name': instance.name,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'deleted_at': instance.deleted_at,
    };
