import 'package:json_annotation/json_annotation.dart';

part 'parades.g.dart';

@JsonSerializable()
class Parades {
  final int id;
  final String? category_product_id;
  final String? name;
  final String? create_by;
  final String? update_by;
  final String? created_at;
  final String? updated_at;
  final int? No;

  Parades(this.id, this.category_product_id, this.name, this.create_by, this.update_by, this.created_at,
      this.updated_at, this.No);

  factory Parades.fromJson(Map<String, dynamic> json) => _$ParadesFromJson(json);

  Map<String, dynamic> toJson() => _$ParadesToJson(this);
}
