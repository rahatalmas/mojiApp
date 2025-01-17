import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/candidate.dart';
import 'package:quizapp/handler/apis/login.dart';

import '../../database/models/admin.dart';


class AdminApi with ChangeNotifier {
  AdminApi._privateConstructor();

  static final AdminApi _instance = AdminApi._privateConstructor();

  factory AdminApi(){
    return _instance;
  }

  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;
  String get message => _message;

  Future<List<Admin>> fetchAdmins() async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    List<Admin> admins = [];
    print("fetching candidates:");
    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
          Uri.parse('$BASE_URL/api/user/list'), headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        admins = jsonData.map((data) => Admin.fromJson(data)).toList();
        print("Admin list fetched, length: "+admins.length.toString());
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
    return admins;
  }

  Future<bool> addAdmin(Admin newAdmin) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode(newAdmin.toJson());

      final response = await http.post(
        Uri.parse('$BASE_URL/api/user/register'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        print('Admin added successfully');
        return true;
      } else {
        _message = 'Error: ${response.statusCode}, ${response.body}';
        return false;
      }
    } catch (e) {
      _message = 'Failed to add Admin: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteAdmin(int id) async {
    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };

      final response = await http.delete(
        Uri.parse('$BASE_URL/api/user/delete/$id'),
        headers: headers,
      );

      if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to delete exam: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}