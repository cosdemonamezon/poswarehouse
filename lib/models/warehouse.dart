import 'package:json_annotation/json_annotation.dart';

part 'warehouse.g.dart';

@JsonSerializable()
class WareHouse {
  final int id;
  final String? category_product_id;
  final String? name;
  final String? create_by;
  final String? update_by;
  final String? created_at;
  final String? updated_at;
  final int? No;

  WareHouse(
    this.id,
    this.category_product_id,
    this.name,
    this.create_by,
    this.update_by,
    this.created_at,
    this.updated_at,
    this.No
  );

  factory WareHouse.fromJson(Map<String, dynamic> json) => _$WareHouseFromJson(json);

  Map<String, dynamic> toJson() => _$WareHouseToJson(this);
}
