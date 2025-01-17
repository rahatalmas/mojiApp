import 'package:json_annotation/json_annotation.dart';

part 'admin.g.dart';

@JsonSerializable()
class Admin {
  @JsonKey(name: 'admin_id')
  final int? adminId;

  @JsonKey(name: 'admin_username')
  final String adminUsername;

  @JsonKey(name:'admin_password')
  final String? password;

  @JsonKey(name: 'admin_role_key')
  final String adminRoleKey;

  Admin({
    this.adminId,
    required this.adminUsername,
    this.password,
    required this.adminRoleKey,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

  Map<String, dynamic> toJson() => _$AdminToJson(this);
}
