import 'package:flutter/material.dart';
import '../database/models/examdetails.dart';
import '../database/models/exammodel.dart';
import '../handler/apis/examApiUtil.dart';

class ExamProvider with ChangeNotifier {
  List<Exam> _exams = [];
  bool _isLoading = false;
  bool _dataUpdated = false;
  String _message = '';
  Exam? _selectedExam;

  // Getters
  List<Exam> get exams => _exams;


  bool get isLoading => _isLoading;

  bool get dataUpdated => _dataUpdated;

  String get message => _message;

  Exam? get selectedExam => _selectedExam;

  void setSelectedExam(Exam exam){
    _selectedExam = exam;
    notifyListeners();
  }
  void reset() {
    _dataUpdated = false;
    notifyListeners();
  }

  Future<void> getAllExams() async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    try {
      _exams = await ExamApiUtil().fetchExams();
      _isLoading = false;
      _dataUpdated = true;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  Future<bool> addExam(Exam newExam) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      bool result = await ExamApiUtil().addExam(newExam);
      _dataUpdated = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _message = 'Failed to add exam: $e';
      return false;
    }
  }

  Future<bool> updateExam(Exam updatedData) async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    try{
       bool result = await ExamApiUtil().updateExam(updatedData);
       _dataUpdated = false;
       _isLoading = false;
       notifyListeners();
       return result;
    }catch(err){
      _message = 'failed to update $err';
      return false;
    }finally{
      _isLoading = false;
      _dataUpdated = false;
    }
  }

  Future<bool> deleteExam(int id) async {
    try {
      bool result = await ExamApiUtil().deleteExam(id);
      _dataUpdated = false;
      _isLoading = false;
      notifyListeners();
      if(result){
        _selectedExam = null;
      }
      return result;
    } catch (e) {
      _message = 'Failed to delete exam: $e';
      return false;
    }
  }
}
