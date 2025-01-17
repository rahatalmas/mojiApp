// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      message: json['message'] as String? ?? '',
      username: json['username'] as String? ?? '',
      accesstoken: json['accesstoken'] as String? ?? '',
      permission: (json['permission'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'message': instance.message,
      'username': instance.username,
      'accesstoken': instance.accesstoken,
      'permission': instance.permission,
    };
