import 'package:flutter/material.dart';
import 'package:quizapp/Widgets/answerCircle.dart';
import 'package:quizapp/constant.dart';

class AnswerCircles extends StatefulWidget {
  const AnswerCircles({super.key});

  @override
  _AnswerCirclesState createState() => _AnswerCirclesState();
}

class _AnswerCirclesState extends State<AnswerCircles> {
  String? _selectedAnswer;

  void _handleAnswerSelection(String label) {
    setState(() {
      _selectedAnswer = label;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('$label selected'),
        duration: Duration(milliseconds: 50),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: neutralWhite,
        border: BorderDirectional(
          bottom: BorderSide(color: neutralBG,width: 2)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < 4; i++)
            AnswerCircle(
              label: String.fromCharCode(65 + i),
              isSelected: _selectedAnswer == String.fromCharCode(65 + i),
              onTap: _handleAnswerSelection,
            ),
        ],
      ),
    );
  }
}
