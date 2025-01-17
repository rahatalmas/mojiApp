import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/handler/api_handler.dart';
import 'package:quizapp/handler/models/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth implements BaseAuthHandler {
  // singleton instance.
  static final Auth _instance = Auth._internal();

  Auth._internal();

  factory Auth() {
    return _instance;
  }

  String? _hasAccessToken;

  String? get hasAccessToken => _hasAccessToken;

  Login? _login;

  Login? get loginData => _login;

  @override
  Future<Login?> checkLoginStatus() async {
    if (_login != null) {
      return _login;
    } else {
      await getAccess();
      return _login;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool removePrefs = await prefs.clear();
      _login = null;
      return removePrefs;
    } catch (e) {
      debugPrint("error logout ${e.toString()}");
      return false;
    }
  }

  @override
  Future<Login?> login(
    BuildContext context, {
    required String user,
    required String password,
  }) async {
    String apiLink = '$BASE_URL/api/user/login';
    try {
      var url = Uri.parse(apiLink);
      var response = await http.post(
        headers: {
          "Content-Type": "application/json",
        },
        url,
        body: jsonEncode({"username": user, "password": password}),
      );

      Login? res = Login.fromJson(jsonDecode(response.body));
      if (res.accesstoken.isNotEmpty) {
        _login = res;
        await setAccessToken();
        return res;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<void> refreshUserToken() {
    // TODO: implement refreshUserToken
    throw UnimplementedError();
  }

  @override
  Future<void> setAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_login != null) {
      if (_login!.accesstoken.isNotEmpty) {
        await prefs.setString('access_token', _login!.accesstoken);
        await prefs.setString('message', _login!.message);
        await prefs.setString('username', _login!.username);
        await prefs.setInt('permission', _login!.permission);
        _hasAccessToken = _login!.accesstoken;
      }
    }
  }

  @override
  Future<void> getAccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final message = prefs.getString('message');
    final userName = prefs.getString('username');
    final permission = prefs.getInt('permission');

    if (token != null &&
        message != null &&
        userName != null &&
        permission != null) {
      _hasAccessToken = token;
      _login = Login(
        accesstoken: token,
        message: message,
        permission: permission,
        username: userName,
      );
    }
  }
}
