import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../database/models/admin.dart';
import '../handler/apis/adminApi.dart';


class AdminProvider with ChangeNotifier {
  List<Admin> _admins = [];
  bool _isLoading = false;
  bool _dataUpdated = false;
  String _message = '';

  List<Admin> get admins => _admins;

  bool get isLoading => _isLoading;

  bool get dataUpdated => _dataUpdated;

  String get message => _message;

  void reset() {
    _dataUpdated = false;
    notifyListeners();
  }

  Future<void> getAllAdmins() async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    try {
      _admins = await AdminApi().fetchAdmins();
      _isLoading = false;
      _dataUpdated = true;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> addAdmin(Admin newAdmin) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      bool result = await AdminApi().addAdmin(newAdmin);
      _dataUpdated = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _message = 'Failed to add admin: $e';
      return false;
    }
  }

  Future<bool> deleteAdmin(int id) async {
    try {
      bool result = await AdminApi().deleteAdmin(id);
      _dataUpdated = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _message = 'Failed to delete admin: $e';
      return false;
    }
  }

}