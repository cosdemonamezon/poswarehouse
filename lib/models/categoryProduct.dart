import 'package:json_annotation/json_annotation.dart';

part 'categoryProduct.g.dart';

@JsonSerializable()
class CategoryProduct {
  final int id;
  final String? name;
  final String? create_by;
  final String? update_by;
  final String? deleted_at;

  CategoryProduct(
    this.id,
    this.name,
    this.create_by,
    this.update_by,
    this.deleted_at
  );

  factory CategoryProduct.fromJson(Map<String, dynamic> json) => _$CategoryProductFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryProductToJson(this);
}
