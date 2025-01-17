import 'package:flutter/cupertino.dart';
import '../database/models/scholar.dart';
import '../handler/apis/scholarApi.dart';

class ScholarProvider with ChangeNotifier {
  List<Scholar> _scholars = [];
  List<Scholar> _fiteredList = [];
  bool _isLoading = false;
  bool _dataUpdated = false;
  bool _filterDataUpdated = false;
  String _message = '';

  // Getters
  List<Scholar> get scholars => _scholars;
  List<Scholar> get filteredScholars => _fiteredList;

  bool get isLoading => _isLoading;

  bool get dataUpdated => _dataUpdated;

  bool get filterDataUpdated => _filterDataUpdated;

  void updateData(){
    _dataUpdated = false;
  }

  String get message => _message;

  void reset() {
    _dataUpdated = false;
    notifyListeners();
  }

  Future<void> getAllScholars() async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      _scholars = await ScholarApi().fetchScholars();
      print(_scholars.length);
      _isLoading = false;
      _dataUpdated = true;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getFilteredScholars(int examId) async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    try {
      _fiteredList = await ScholarApi().fetchFilteredScholars(examId);
      print(_fiteredList);
      _isLoading = false;
      _filterDataUpdated = true;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  Future<bool> addScholar(Scholar newScholar) async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    try {
      bool result = await ScholarApi().addScholar(newScholar);
      _dataUpdated = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _message = 'Failed to add Scholar: $e';
      return false;
    }
  }

  Future<bool> updateScholar(Scholar newScholar) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      bool result = await ScholarApi().updateScholar(newScholar);
      print(result);
      _dataUpdated = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _message = 'Failed to update scholar: $e';
      return false;
    }
  }

  Future<bool> deleteScholar(int id) async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    try {
      bool result = await ScholarApi().deleteScholar(id);
      _dataUpdated = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _message = 'Failed to delete Scholar: $e';
      return false;
    }
  }

}
