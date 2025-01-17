import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  Login({
    this.message = "",
    this.username = "",
    this.accesstoken = "",
    this.permission = 0,
  });

  @JsonKey(defaultValue: "")
  final String message;

  @JsonKey(defaultValue: "")
  final String username;

  @JsonKey(defaultValue: "")
  final String accesstoken;

  @JsonKey(defaultValue: 0)
  final int permission;

  factory Login.fromJson(Map<String, dynamic>? json) {
    return _$LoginFromJson(Map<String, dynamic>.from(json ?? {}));
  }

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

class LoginProvider extends ChangeNotifier {
  Login _login = Login.fromJson({});
  bool _dataUpdated = false;

  bool get dataUpdated => _dataUpdated;

  Login get login => _login;

  Future<bool?> hasAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var hasToken = prefs.getString('accessToken')?.isNotEmpty;
    return hasToken;
  }

  void updateToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }
}
