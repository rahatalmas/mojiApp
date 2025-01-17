import 'package:flutter/material.dart';

import '../database/models/question.dart';

class QuestionProvider with ChangeNotifier {
  List<Question> _questions = [];

  List<Question> get questions => List.unmodifiable(_questions);

  get questionCount => _questions.length;

  // Method to get questions
  List<Question> getQuestions() {
    return _questions;
  }

  void resetQuestions() {
    _questions.clear();
    notifyListeners();
  }

  void editQuestion(int index, Question updatedQuestion) {
    if (index >= 0 && index < _questions.length) {
      _questions[index] = updatedQuestion;
      notifyListeners();
    }
  }
  void removeQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _questions.removeAt(index);
      notifyListeners();
    }
  }
  void addQuestion(Question newQuestion) {
    _questions.add(newQuestion);
    notifyListeners();
  }
}
