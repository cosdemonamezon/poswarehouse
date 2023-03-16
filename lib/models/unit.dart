import 'package:json_annotation/json_annotation.dart';

part 'unit.g.dart';

@JsonSerializable()
class Unit {
  final int id;
  final String? name;
  final String? create_by;
  final String? update_by;
  final String? deleted_at;
  final int? No;
  bool? selected;

  Unit(
    this.id,
    this.name,
    this.create_by,
    this.update_by,
    this.deleted_at,
    this.No,
    this.selected,
  );

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);
}
