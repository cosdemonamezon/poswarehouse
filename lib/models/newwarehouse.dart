import 'package:json_annotation/json_annotation.dart';

part 'newwarehouse.g.dart';

@JsonSerializable()
class NewWareHouse {
  String warehouseName;
  String categoryId;

  NewWareHouse(
    this.warehouseName,
    this.categoryId,
  );

  factory NewWareHouse.fromJson(Map<String, dynamic> json) => _$NewWareHouseFromJson(json);

  Map<String, dynamic> toJson() => _$NewWareHouseToJson(this);
}
