import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/user.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  final User? user;
  final String? token;

  Login(
    this.user,
    this.token,
  );

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
