import 'package:json_annotation/json_annotation.dart';

part 'unit.g.dart';

@JsonSerializable()
class Unit {
  final int id;
  final String? name;
  final String? create_by;
  final String? update_by;
  final String? deleted_at;

  Unit(
    this.id,
    this.name,
    this.create_by,
    this.update_by,
    this.deleted_at
  );

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);
}
