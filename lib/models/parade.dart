import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/parades.dart';

part 'parade.g.dart';

@JsonSerializable()
class Parade {
  final int current_page;
  final List<Parades>? data;
  final String? first_page_url;
  final int? from;
  final int? last_page;
  final String? last_page_url;
  final String? path;
  final int? per_page;
  final int? to;
  final int? total;

  Parade(
    this.current_page,
    this.data,
    this.first_page_url,
    this.from,
    this.last_page,
    this.last_page_url,
    this.path,
    this.per_page,
    this.to,
    this.total
  );

  factory Parade.fromJson(Map<String, dynamic> json) => _$ParadeFromJson(json);

  Map<String, dynamic> toJson() => _$ParadeToJson(this);
}
