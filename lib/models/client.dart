import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final String? created_at;
  final String? updated_at;
  final int? change;
  

  Client( 
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.created_at,
    this.updated_at,
    this.change
  );

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
