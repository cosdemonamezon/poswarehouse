import 'package:json_annotation/json_annotation.dart';

part 'typeProduct.g.dart';

@JsonSerializable()
class TypeProduct {
  final int id;
  final String? name;
  final String? create_by;
  final String? update_by;
  final String? created_at;
  final String? deleted_at;
  final int? No;

  TypeProduct(
    this.id,
    this.name,
    this.create_by,
    this.update_by,
    this.created_at,
    this.deleted_at,
    this.No
  );

  factory TypeProduct.fromJson(Map<String, dynamic> json) => _$TypeProductFromJson(json);

  Map<String, dynamic> toJson() => _$TypeProductToJson(this);
}
