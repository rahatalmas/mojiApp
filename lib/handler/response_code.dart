import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResponseCode {
  String errorStatus(BuildContext context, http.Response res) {
    String message = jsonDecode(res.body)['message'];
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      return message;
    } else if (res.statusCode == 404) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      return message;
    }
    return '';
  }
}
