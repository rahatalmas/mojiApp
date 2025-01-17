import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Widgets/examFilter.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/result.dart';
import 'package:quizapp/providers/resultProvider.dart';

import '../../providers/examProvider.dart';

class ResultAddScreen extends StatefulWidget {
  const ResultAddScreen({super.key, this.result});

  final Result? result;

  @override
  State<ResultAddScreen> createState() => _ResultAddScreenState();
}

class _ResultAddScreenState extends State<ResultAddScreen> {
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _correctAnswersController = TextEditingController();
  final TextEditingController _incorrectAnswersController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();

  final InputDecoration _textFieldDecoration = InputDecoration(
    labelText: "Type here...",
    hintText: "Enter value",
    hintStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(color: Colors.black),
    prefixIcon: const Padding(
      padding: EdgeInsets.only(left: 15, right: 5),
      child: Icon(Icons.input, size: 30, color: kColorPrimary),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
    ),
    fillColor: Colors.white,
    filled: true,
  );

  @override
  void initState() {
    if (widget.result != null) {
      _serialNumberController.text = widget.result!.serialNumber.toString();
      _correctAnswersController.text = widget.result!.correctAnswers.toString();
      _incorrectAnswersController.text = widget.result!.incorrectAnswers.toString();
      _gradeController.text = widget.result!.grade;
    }
    super.initState();
  }

  void _saveResult() async {
    final resultProvider = Provider.of<ResultProvider>(context, listen: false);
    final examProvider = Provider.of<ExamProvider>(context, listen: false);

    if (_serialNumberController.text.isEmpty ||
        _correctAnswersController.text.isEmpty ||
        _incorrectAnswersController.text.isEmpty ||
        _gradeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required.")),
      );
      return;
    }

    final result = Result(
      examId: examProvider.selectedExam!.id,
      serialNumber: int.parse(_serialNumberController.text),
      correctAnswers: int.parse(_correctAnswersController.text),
      incorrectAnswers: int.parse(_incorrectAnswersController.text),
      grade: _gradeController.text,
    );

    bool success = await resultProvider.addResult(result);

    if (success) {
      await resultProvider.getAllResults();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Result saved successfully.")),
      );
      //Navigator.pop(context);
      resultProvider.getAllResults();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to save result.")),
      );
    }
  }

  @override
  void dispose() {
    _serialNumberController.dispose();
    _correctAnswersController.dispose();
    _incorrectAnswersController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
    KeyboardVisibilityProvider.isKeyboardVisible(context);
    final resultProvider = Provider.of<ResultProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.result != null ? "Edit Result" : "Add Result",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: neutralWhite,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 3,
        shadowColor: Colors.grey,
      ),
      backgroundColor: neutralWhite,
      body: resultProvider.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                    children: [
            ExamFilterWidget(),
            Expanded(
              child: ListView(

                children: [
                 const SizedBox(height: 12,),
                 Image.asset("assets/images/leading3.png",width: 200,height: 200,),

                  const SizedBox(height: 16,),
                  // Serial Number Field
                  TextField(
                    controller: _serialNumberController,
                    decoration: _textFieldDecoration.copyWith(
                      labelText: "Serial Number",
                      hintText: "Enter serial number",
                      prefixIcon: const Icon(Icons.numbers),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Correct Answers Field
                  TextField(
                    controller: _correctAnswersController,
                    decoration: _textFieldDecoration.copyWith(
                      labelText: "Correct Answers",
                      hintText: "Enter number of correct answers",
                      prefixIcon: const Icon(Icons.check_circle),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Incorrect Answers Field
                  TextField(
                    controller: _incorrectAnswersController,
                    decoration: _textFieldDecoration.copyWith(
                      labelText: "Incorrect Answers",
                      hintText: "Enter number of incorrect answers",
                      prefixIcon: const Icon(Icons.cancel),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Grade Field
                  TextField(
                    controller: _gradeController,
                    decoration: _textFieldDecoration.copyWith(
                      labelText: "Grade",
                      hintText: "Enter grade (e.g., A, B, C)",
                      prefixIcon: const Icon(Icons.grade),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !isKeyboardVisible,
              child: InkWell(
                onTap: _saveResult,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Save",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
                    ],
                  ),
          ),
    );
  }
}
