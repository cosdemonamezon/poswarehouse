// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['id'] as int,
      json['code'] as String?,
      json['image'] as String?,
      json['category_product_id'] as int?,
      json['sub_category_id'] as int?,
      json['unit_id'] as int?,
      json['name'] as String?,
      json['detail'] as String?,
      json['cost'] as int?,
      (json['price_for_retail'] as num?)?.toDouble(),
      (json['price_for_wholesale'] as num?)?.toDouble(),
      (json['price_for_box'] as num?)?.toDouble(),
      json['remain'] as int?,
      json['remain_shop'] as int?,
      json['min'] as int?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      json['createdAt'] as String?,
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['No'] as int?,
      json['category_product'] == null
          ? null
          : CategoryProduct.fromJson(
              json['category_product'] as Map<String, dynamic>),
      json['sub_category'] == null
          ? null
          : SubCategory.fromJson(json['sub_category'] as Map<String, dynamic>),
      json['unit'] == null
          ? null
          : Unit.fromJson(json['unit'] as Map<String, dynamic>),
      json['selected'] as bool?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'image': instance.image,
      'category_product_id': instance.category_product_id,
      'sub_category_id': instance.sub_category_id,
      'unit_id': instance.unit_id,
      'name': instance.name,
      'detail': instance.detail,
      'cost': instance.cost,
      'price_for_retail': instance.price_for_retail,
      'price_for_wholesale': instance.price_for_wholesale,
      'price_for_box': instance.price_for_box,
      'remain': instance.remain,
      'remain_shop': instance.remain_shop,
      'min': instance.min,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'No': instance.No,
      'category_product': instance.category_product,
      'sub_category': instance.sub_category,
      'unit': instance.unit,
      'selected': instance.selected,
    };
