import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/constant.dart'; // Assuming BASE_URL is defined here
import 'package:quizapp/handler/apis/login.dart'; // Assuming Auth class is defined here
import '../../database/models/answer.dart'; // Import the Answer model file

class AnswerApi with ChangeNotifier {
  AnswerApi._privateConstructor();

  static final AnswerApi _instance = AnswerApi._privateConstructor();

  factory AnswerApi() {
    return _instance;
  }

  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;
  String get message => _message;

  // Fetch answers for a specific exam by examId
  Future<List<Answer>> fetchAnswers(int examId) async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    List<Answer> answers = [];
    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse('$BASE_URL/api/answer/all/$examId'),
        headers: headers,
      );

      print("status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        answers = jsonData.map((data) => Answer.fromJson(data)).toList();
      } else {
        _message = 'Error ${response.statusCode}';
      }
    } catch (err) {
      print(err);
      _message = 'Failed to fetch answers';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return answers;
  }

  // Add an answer to the server
  Future<bool> addAnswer(Answer answer) async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    bool isSuccess = false;
    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        Uri.parse('$BASE_URL/api/answer/add'),
        headers: headers,
        body: json.encode(answer.toJson()),
      );

      print("status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        isSuccess = true;
      } else {
        _message = 'Error ${response.statusCode}';
      }
    } catch (err) {
      print(err);
      _message = 'Failed to add answer';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return isSuccess;
  }

  // Update an answer
  Future<bool> updateAnswer(Answer answer) async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    bool isSuccess = false;
    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };

      final response = await http.put(
        Uri.parse('$BASE_URL/api/answer/update'),
        headers: headers,
        body: json.encode(answer.toJson()),
      );

      print("status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        isSuccess = true;
      } else {
        _message = 'Error ${response.statusCode}';
      }
    } catch (err) {
      print(err);
      _message = 'Failed to update answer';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return isSuccess;
  }

  // Reset the message and loading state
  void reset() {
    _message = '';
    _isLoading = false;
    notifyListeners();
  }
}
