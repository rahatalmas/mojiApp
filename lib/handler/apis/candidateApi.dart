import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/candidate.dart';
import 'package:quizapp/handler/apis/login.dart';


class CandidateApi with ChangeNotifier {
  CandidateApi._privateConstructor();

  static final CandidateApi _instance = CandidateApi._privateConstructor();

  factory CandidateApi(){
    return _instance;
  }

  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;
  String get message => _message;

  Future<List<Candidate>> fetchCandidates(int examId) async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    List<Candidate> candidates = [];
    print("fetching candidates:");
    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
          Uri.parse('$BASE_URL/api/candidate/$examId'), headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        candidates = jsonData.map((data) => Candidate.fromJson(data)).toList();
        print("candidate list fetched, length; "+candidates.length.toString());
      } else {
        _message = 'Error ${response.statusCode}';
      }
    } catch (err) {
      print('Failed to fetch candidates: $err');
      _message = 'Failed to fetch candidates: $err';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return candidates;
  }

  Future<bool> addCandidate(Candidate newCandidate) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode(newCandidate.toJson());

      final response = await http.post(
        Uri.parse('$BASE_URL/api/candidate/add'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        print('Candidate added successfully');
        return true;
      } else {
        print("eroor error error");
        _message = 'Error: ${response.statusCode}, ${response.body}';
        return false;
      }
    } catch (e) {
      _message = 'Failed to add Candidate: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteCandidate(int id,int examId) async {
    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };

      final response = await http.delete(
        Uri.parse('$BASE_URL/api/candidate/delete/$id/$examId'),
        headers: headers,
      );

      if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to delete Candidate: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}