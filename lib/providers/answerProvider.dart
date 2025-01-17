import 'package:flutter/cupertino.dart';
import '../database/models/answer.dart';
import '../handler/apis/answerApi.dart';

class AnswerProvider with ChangeNotifier {
  List<Answer> _answers = [];
  bool _isLoading = false;
  bool _dataUpdated = false;
  String _message = '';

  // Getters
  List<Answer> get answers => _answers;
  bool get isLoading => _isLoading;
  bool get dataUpdated => _dataUpdated;
  String get message => _message;

  // Reset dataUpdated flag
  void updateData() {
    _dataUpdated = false;
  }

  // Reset method
  void reset() {
    _dataUpdated = false;
    notifyListeners();
  }

  // Fetch all answers
  Future<void> getAllAnswers(int examId) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      _answers = await AnswerApi().fetchAnswers(examId);
      _isLoading = false;
      _dataUpdated = true;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _message = 'Failed to fetch answers: $e';
      notifyListeners();
    }
  }

  // Add a new answer
  Future<bool> addAnswer(Answer newAnswer) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      bool result = await AnswerApi().addAnswer(newAnswer);
      _dataUpdated = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _message = 'Failed to add answer: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update an existing answer
  Future<bool> updateAnswer(Answer updatedAnswer) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      bool result = await AnswerApi().updateAnswer(updatedAnswer);
      _dataUpdated = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _message = 'Failed to update answer: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
