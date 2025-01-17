import 'package:flutter/material.dart';
import 'package:quizapp/handler/apis/login.dart';
import 'package:quizapp/handler/models/login.dart';
import 'package:quizapp/pdf/screens/view_document.dart';
import 'package:quizapp/screens/auth/login_screen.dart';

import 'main.dart';

class RouteNames {
  static const String landing = "/";
  static const String login = "/login";
  static const String viewDocument = '/view_document';
}

Route? routes(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.landing:
      return MaterialPageRoute(builder: (context) {
        return FutureBuilder<Login?>(
            future: Auth().checkLoginStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text('Error fetching token');
              }
              var hasLoginData = snapshot.data;

              if (hasLoginData != null) {
                return const Root(title: 'Root');
              }
              return const LoginScreen();
            });
      });
    case RouteNames.viewDocument:
      return MaterialPageRoute(builder: (context){
        return const ViewDocument();
      });
    default:
      return null;
  }
}
