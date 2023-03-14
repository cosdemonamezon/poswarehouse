import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/categoryProduct.dart';
import 'package:poswarehouse/models/subCategory.dart';
import 'package:poswarehouse/models/unit.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String? code;
  final String? image;
  final String? category_product_id;
  final String? sub_category_id;
  final String? unit_id;
  final String? name;
  final String? detail;
  final String? cost;
  final String? price_for_retail;
  final String? price_for_wholesale;
  final String? price_for_box;
  final String? remain;
  final String? remain_shop;
  final String? min;
  final String? create_by;
  final String? update_by;
  final String? createdAt;
  final DateTime? updatedAt;
  final int? No;
  final CategoryProduct? category_product;
  final SubCategory? sub_category;
  final Unit? unit;
  bool? selected;

  Product(
    this.id,
    this.code,
    this.image,
    this.category_product_id,
    this.sub_category_id,
    this.unit_id,
    this.name,
    this.detail,
    this.cost,
    this.price_for_retail,
    this.price_for_wholesale,
    this.price_for_box,
    this.remain,
    this.remain_shop,
    this.min,
    this.create_by,
    this.update_by,
    this.createdAt,
    this.updatedAt,
    this.No,
    this.category_product,
    this.sub_category,
    this.unit,
    this.selected
  );

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
