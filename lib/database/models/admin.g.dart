// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin(
      adminId: (json['admin_id'] as num?)?.toInt(),
      adminUsername: json['admin_username'] as String,
      password: json['admin_password'] as String?,
      adminRoleKey: json['admin_role_key'] as String,
    );

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'admin_id': instance.adminId,
      'admin_username': instance.adminUsername,
      'admin_password': instance.password,
      'admin_role_key': instance.adminRoleKey,
    };
