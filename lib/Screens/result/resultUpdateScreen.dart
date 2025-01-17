import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/resultProvider.dart';

import '../../database/models/result.dart';

class ResultUpdateScreen extends StatefulWidget {
  final int examId;
  final int serialNumber;
  final int correctAnswers;
  final int incorrectAnswers;
  final String grade;

  const ResultUpdateScreen({
    super.key,
    required this.examId,
    required this.serialNumber,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.grade,
  });

  @override
  State<ResultUpdateScreen> createState() => _ResultUpdateScreenState();
}

class _ResultUpdateScreenState extends State<ResultUpdateScreen> {
  late ResultProvider _resultProvider;
  late TextEditingController _serialNumberController;
  late TextEditingController _correctAnswersController;
  late TextEditingController _incorrectAnswersController;
  late TextEditingController _gradeController;

  final InputDecoration _textFieldDecoration = InputDecoration(
    labelText: "Type here...",
    hintText: "Enter value",
    hintStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(color: Colors.black),
    prefixIcon: Padding(
      padding: const EdgeInsets.only(left: 15, right: 5),
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
    super.initState();
    _resultProvider = Provider.of<ResultProvider>(context, listen: false);

    // Initialize controllers with the passed-in values
    _serialNumberController = TextEditingController(text: widget.serialNumber.toString());
    _correctAnswersController = TextEditingController(text: widget.correctAnswers.toString());
    _incorrectAnswersController = TextEditingController(text: widget.incorrectAnswers.toString());
    _gradeController = TextEditingController(text: widget.grade);
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
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Update Result",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: neutralWhite,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 3,
          shadowColor: Colors.grey,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Pop until you reach the first screen in the navigation stack
              //Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
        
      backgroundColor: neutralWhite,
      body: _resultProvider.isLoading
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/animations/geometryloader.json", height: 125),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/leading1.png",
                      height: 250,
                      width: 250,
                    )
                  ],
                ),
                SizedBox(height: 16),
                // Serial Number Field
                TextField(
                  controller: _serialNumberController,
                  keyboardType: TextInputType.number,
                  decoration: _textFieldDecoration.copyWith(
                      labelText: "Serial Number",
                      hintText: "Enter serial number",
                      prefixIcon: const Icon(Icons.format_list_numbered)),
                ),
                const SizedBox(height: 10),
                // Correct Answers Field
                TextField(
                  controller: _correctAnswersController,
                  keyboardType: TextInputType.number,
                  decoration: _textFieldDecoration.copyWith(
                      labelText: "Correct Answers",
                      hintText: "Enter correct answers",
                      prefixIcon: const Icon(Icons.check_circle_outline)),
                ),
                const SizedBox(height: 10),
                // Incorrect Answers Field
                TextField(
                  controller: _incorrectAnswersController,
                  keyboardType: TextInputType.number,
                  decoration: _textFieldDecoration.copyWith(
                      labelText: "Incorrect Answers",
                      hintText: "Enter incorrect answers",
                      prefixIcon: const Icon(Icons.cancel_outlined)),
                ),
                const SizedBox(height: 10),
                // Grade Field
                TextField(
                  controller: _gradeController,
                  decoration: _textFieldDecoration.copyWith(
                      labelText: "Grade",
                      hintText: "Enter grade",
                      prefixIcon: const Icon(Icons.grade)),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () async {
                  print("Updated Result Details:");
                  print("Serial Number: ${_serialNumberController.text}");
                  print("Correct Answers: ${_correctAnswersController.text}");
                  print("Incorrect Answers: ${_incorrectAnswersController.text}");
                  print("Grade: ${_gradeController.text}");

                  Result updatedResult = Result(
                    examId: widget.examId,
                    serialNumber: int.parse(_serialNumberController.text),
                    correctAnswers: int.parse(_correctAnswersController.text),
                    incorrectAnswers: int.parse(_incorrectAnswersController.text),
                    grade: _gradeController.text,
                  );

                  bool isSuccess =  await _resultProvider.updateResult(updatedResult,widget.examId);

                  if (isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration.zero,
                        content: Text('Result updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration.zero,
                        content: Text('Failed to update result'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Update",
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
          )
        ],
      ),
    );
  }
}
