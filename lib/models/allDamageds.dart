import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/receiving.dart';

part 'allDamageds.g.dart';

@JsonSerializable()
class AllDamageds {
  final int current_page;
  List<Receiving>? data;
  final String? first_page_url;
  final int? from;
  final int? last_page;
  final String? last_page_url;
  final String? next_page_url;
  final int? per_page;
  final int? to;
  final int? total;

  AllDamageds(
    this.current_page,
    this.data,
    this.first_page_url,
    this.from,
    this.last_page,
    this.last_page_url,
    this.next_page_url,
    this.per_page,
    this.to,
    this.total,
  );

  factory AllDamageds.fromJson(Map<String, dynamic> json) => _$AllDamagedsFromJson(json);

  Map<String, dynamic> toJson() => _$AllDamagedsToJson(this);
}
