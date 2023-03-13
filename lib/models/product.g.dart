// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['id'] as int,
      json['image'] as String?,
      json['category_product_id'] as String?,
      json['sub_category_id'] as String?,
      json['unit_id'] as String?,
      json['name'] as String?,
      json['detail'] as String?,
      json['cost'] as String?,
      json['price_for_retail'] as String?,
      json['price_for_wholesale'] as String?,
      json['price_for_box'] as String?,
      json['remain'] as String?,
      json['remain_shop'] as String?,
      json['min'] as String?,
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
