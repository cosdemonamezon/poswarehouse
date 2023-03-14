import 'package:json_annotation/json_annotation.dart';

part 'subCategory.g.dart';

@JsonSerializable()
class SubCategory {
  final int id;
  final int? category_product_id;
  final String? name;
  final String? create_by;
  final String? update_by;
  final String? deleted_at;

  SubCategory(
    this.id,
    this.category_product_id,
    this.name,
    this.create_by,
    this.update_by,
    this.deleted_at
  );

  factory SubCategory.fromJson(Map<String, dynamic> json) => _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}
