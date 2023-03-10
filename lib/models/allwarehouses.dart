import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/models/warehouse.dart';

part 'allwarehouses.g.dart';

@JsonSerializable()
class AllWareHouses {
  final int current_page;
  final List<WareHouse>? data;
  final String? first_page_url;
  final int? from;
  final int? last_page;
  final String? last_page_url;
  final String? next_page_url;
  final int? per_page;
  final int? to;
  final int? total;

  AllWareHouses(
    this.current_page,
    this.data,
    this.first_page_url,
    this.from,
    this.last_page,
    this.last_page_url,
    this.next_page_url,
    this.per_page,
    this.to,
    this.total
  );

  factory AllWareHouses.fromJson(Map<String, dynamic> json) => _$AllWareHousesFromJson(json);

  Map<String, dynamic> toJson() => _$AllWareHousesToJson(this);
}
