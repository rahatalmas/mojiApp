import 'package:flutter/cupertino.dart';
import 'package:quizapp/handler/models/login.dart';

/// Abstract class for authentication.
abstract class BaseAuthHandler {
  Future<Login?> checkLoginStatus();

  // function to return login information.
  Future<Login?> login(BuildContext context, {required String user, required String password});

  Future<bool> logout();

  Future<void> refreshUserToken();

  Future<void> setAccessToken();

  Future<void> getAccess();
}
