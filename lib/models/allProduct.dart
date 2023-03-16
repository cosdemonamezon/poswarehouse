import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/product.dart';

part 'allProduct.g.dart';

@JsonSerializable()
class AllProduct {
  final int current_page;
  List<Product>? data;
  final String? first_page_url;
  final int? from;
  final int? last_page;
  final String? last_page_url;
  final String? next_page_url;
  final int? per_page;
  final int? to;
  final int? total;

  AllProduct(this.current_page, this.data, this.first_page_url, this.from, this.last_page, this.last_page_url,
      this.next_page_url, this.per_page, this.to, this.total);

  factory AllProduct.fromJson(Map<String, dynamic> json) => _$AllProductFromJson(json);

  Map<String, dynamic> toJson() => _$AllProductToJson(this);
}
