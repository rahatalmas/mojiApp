import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/constant.dart';
import 'package:quizapp/handler/apis/login.dart';
import '../../database/models/getresult.dart';
import '../../database/models/result.dart';

class ResultApi with ChangeNotifier {
  ResultApi._privateConstructor();

  static final ResultApi _instance = ResultApi._privateConstructor();

  factory ResultApi() {
    return _instance;
  }

  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;
  String get message => _message;

  // Fetch results from the server
  Future<List<GetResult>> fetchResults() async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    List<GetResult> results = [];
    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse('$BASE_URL/api/result/allresult'),
        headers: headers,
      );

      print("status code"+response.statusCode.toString());
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        results = jsonData.map((data) => GetResult.fromJson(data)).toList();
      } else {
        _message = 'Error ${response.statusCode}';
      }
    } catch (err) {
      print(err);
      _message = 'Failed to fetch results';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return results;
  }

  Future<bool> addResult(Result newResult) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode(newResult.toJson());

      final response = await http.post(
        Uri.parse('$BASE_URL/api/result/add'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        print('Result added successfully');
        return true;
      } else {
        _message = 'Error: ${response.statusCode}, ${response.body}';
        return false;
      }
    } catch (e) {
      _message = 'Failed to add result: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateResult(Result updatedResult,int examId) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode(updatedResult.toJson());

      final response = await http.put(
        Uri.parse('$BASE_URL/api/result/update/${examId}'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 204) {
        print(response.statusCode);
        print('Result updated successfully');
        return true;
      } else {
        _message = 'Error: ${response.statusCode}, ${response.body}';
        return false;
      }
    } catch (e) {
      _message = 'Failed to update result: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  //method to reset the message and loading state
  void reset() {
    _message = '';
    _isLoading = false;
    notifyListeners();
  }
}
