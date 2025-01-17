import 'package:flutter/material.dart';
import 'package:quizapp/handler/apis/resultApi.dart';
import 'package:quizapp/database/models/getresult.dart';

import '../database/models/result.dart';

class ResultProvider with ChangeNotifier {
  List<GetResult> _results = [];
  List<Map<String, dynamic>> _groupedResults = [];
  bool _isLoading = false;
  bool _dataUpdated = false;
  String _message = '';

  List<GetResult> get results => _results;
  List<Map<String, dynamic>> get groupedResults => _groupedResults;
  bool get isLoading => _isLoading;
  bool get dataUpdated => _dataUpdated;
  String get message => _message;

  // Reset state
  void reset() {
    _dataUpdated = false;
    _message = '';
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAllResults() async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      _results = await ResultApi().fetchResults();
      _groupResults(_results);
      _isLoading = false;
      _dataUpdated = true;
      notifyListeners();
    } catch (e) {
      _message = 'Failed to fetch results: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addResult(Result newResult) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      bool  res = await ResultApi().addResult(newResult);
      _isLoading = false;
      _dataUpdated = false;
      notifyListeners();
      return res;
    } catch (e) {
      _message = 'Failed to add result: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateResult(Result updateResult,int examId) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      bool  res = await ResultApi().updateResult(updateResult, examId);
      _isLoading = false;
      _dataUpdated =false;
      notifyListeners();
      return res;
    } catch (e) {
      _message = 'Failed to update result: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void _groupResults(List<GetResult> fetchedResults) {
    Map<int, Map<String, dynamic>> examsMap = {};

    for (var result in fetchedResults) {
      if (!examsMap.containsKey(result.examId)) {
        examsMap[result.examId] = {
          'exam_id': result.examId,
          'exam_name': result.examName,
          'exam_date': result.examDate,
          'exam_location': result.examLocation,
          'exam_duration': result.examDuration,
          'question_count': result.questionCount,
          'candidate_count': result.candidateCount,
          'candidates': [],
          'fail_count': 0
        };
      }


      if (result.grade == 'F') {
        examsMap[result.examId]!['fail_count'] += 1;
      }

      examsMap[result.examId]?['candidates'].add({
        'serial_number': result.serialNumber,
        'candidate_name': result.candidateName,
        'school_name': result.schoolName,
        'class_level': result.classLevel,
        'candidate_picture': result.candidatePicture,
        'scholar_id': result.scholarId,
        'correct_answers': result.correctAnswers,
        'incorrect_answers': result.incorrectAnswers,
        'grade': result.grade,
      });
    }

    _groupedResults = examsMap.values.toList();
  }

  Map<String, dynamic> getResultByExamId(int examId) {
    return _groupedResults.firstWhere(
          (exam) => exam['exam_id'] == examId,
      orElse: () {
        throw Exception('No result found for examId: $examId');
      },
    );
  }

}
