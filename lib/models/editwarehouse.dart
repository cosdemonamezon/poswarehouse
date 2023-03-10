import 'package:json_annotation/json_annotation.dart';

part 'editwarehouse.g.dart';

@JsonSerializable()
class EditWareHouse {
  int id;
  String name;

  EditWareHouse(
    this.id,
    this.name,
  );

  factory EditWareHouse.fromJson(Map<String, dynamic> json) => _$EditWareHouseFromJson(json);

  Map<String, dynamic> toJson() => _$EditWareHouseToJson(this);
}
