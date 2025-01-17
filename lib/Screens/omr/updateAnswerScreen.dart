import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/database/models/answer.dart';
import 'package:quizapp/providers/answerProvider.dart';
import 'package:quizapp/constant.dart';

import '../../database/models/exammodel.dart';

class UpdateAnswerScreen extends StatefulWidget {
  final Exam exam; // Receive examId as a constructor parameter

  const UpdateAnswerScreen({super.key, required this.exam});

  @override
  _UpdateAnswerScreenState createState() => _UpdateAnswerScreenState();
}

class _UpdateAnswerScreenState extends State<UpdateAnswerScreen> {
  late AnswerProvider _answerProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _answerProvider = context.watch<AnswerProvider>();
    if (!_answerProvider.dataUpdated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _answerProvider.getAllAnswers(widget.exam.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final answerProvider = Provider.of<AnswerProvider>(context);
    final answers = answerProvider.answers;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Answers",
          style: TextStyle(color: appTextPrimary),
        ),
        centerTitle: true,
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: appTextPrimary),
        elevation: 3,
        shadowColor: Colors.grey,
      ),
      backgroundColor: neutralWhite,
      body:
      answerProvider.isLoading
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/animations/geometryloader.json", height: 125),
          ],
        ),
      )
          :
      Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: answers.length,
              itemBuilder: (context, index) {
                final answer = answers[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Question: ${answer.questionNumber}'),
                          const SizedBox(width: 20),
                        ],
                      ),
                      AnswerCircles(
                        questionNumber: answer.questionNumber,
                        correctAnswer: answer.correctAnswer,
                        onAnswerSelect: (int selectedAnswer) {
                          // Updating the whole answer object with selected answer
                          Answer updatedAnswer = Answer(
                              examId: widget.exam.id,
                              questionSetId:1,
                              questionNumber: answer.questionNumber,
                              correctAnswer: selectedAnswer
                          );
                          _answerProvider.updateAnswer(updatedAnswer); // Pass the updated object
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context); // Navigate back when the button is pressed
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: neutralWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnswerCircles extends StatelessWidget {
  final int questionNumber;
  final int correctAnswer;
  final Function(int) onAnswerSelect;

  const AnswerCircles({
    super.key,
    required this.questionNumber,
    required this.correctAnswer,
    required this.onAnswerSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: neutralWhite,
        border: const BorderDirectional(
          bottom: BorderSide(color: neutralBG, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < 4; i++)
            InkWell(
              onTap: () => onAnswerSelect(i + 1),
              child: AnswerCircle(
                label: String.fromCharCode(65 + i),
                isSelected: (i + 1) == correctAnswer,
              ),
            ),
        ],
      ),
    );
  }
}

class AnswerCircle extends StatelessWidget {
  final String label;
  final bool isSelected;

  const AnswerCircle({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.green : Colors.blue,
        // border: Border.all(
        //   color: isSelected ? Colors.green : Colors.black, // Border for unselected circles
        // ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: neutralWhite,
          ),
        ),
      ),
    );
  }
}
