import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String? username;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? status;
  final String? create_by;
  final String? update_by;

  User(
    this.id,
    this.username,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.status,
    this.create_by,
    this.update_by,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
