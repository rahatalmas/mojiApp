import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/handler/apis/candidateApi.dart';
import 'package:quizapp/providers/scholarProvider.dart';
import '../database/models/candidate.dart';
import '../handler/apis/login.dart';

class CandidateProvider with ChangeNotifier {
  List<Candidate> _candidates = [];
  bool _isLoading = false;
  bool _dataUpdated = false;
  String _message = '';

  List<Candidate> get candidates => _candidates;
  bool get isLoading => _isLoading;
  bool get dataUpdated => _dataUpdated;
  String get message => _message;

  void reset() {
    _dataUpdated = false;
    notifyListeners();
  }

  Future<void> getAllCandidates(int examId) async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    try {
      _candidates = await CandidateApi().fetchCandidates(examId);
      _isLoading = false;
      _dataUpdated = true;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  Future<bool> addCandidate(Candidate newCandidate) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      bool result = await CandidateApi().addCandidate(newCandidate);
      _dataUpdated = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _message = 'Failed to add exam: $e';
      return false;
    }
  }

  Future<int> addMultipleCandidate(List<Candidate> newCandidates,int examId) async {
    int count = 0;
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      //print("length from add mul "+newCandidates.length.toString());
      for (int i=0;i<newCandidates.length;i++) {
        bool result = await CandidateApi().addCandidate(newCandidates[i]);
        if (result) {
          count++;
          //print("print: " + count.toString());
        }
      }

      //if (count > 0) {
        //print("print count: " + count.toString());
        await getAllCandidates(examId);
        _dataUpdated = false;
        _isLoading = false;
        notifyListeners();
      //}
      return count;
    } catch (err) {
      _message = 'Failed to add exam: $err';
      _isLoading = false;
      notifyListeners();
      return 0;
    }
  }

  Future<bool> deleteCandidate(int id,int examId) async {
    try {
      bool result = await CandidateApi().deleteCandidate(id, examId);
      _dataUpdated = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _message = 'Failed to delete Candidate: $e';
      return false;
    }
  }

}

