import 'package:flutter/material.dart';
import 'package:quizapp/constant.dart';

class QuestionCard extends StatelessWidget {
  final int questionId;
  final String questionName;
  final String? questionPicture;
  final int numberOfQuestions;

  const QuestionCard({
    Key? key,
    required this.questionId,
    required this.questionName,
    required this.questionPicture,
    required this.numberOfQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      color: neutralWhite,
      shadowColor: Colors.black87,
      elevation: 4,
      child: ListTile(
        //leading: CircleAvatar(backgroundImage: AssetImage("assets/images/man.png")),
        title: Text(questionName),
        subtitle: Text('Total Questions: $numberOfQuestions'),
        trailing: const SizedBox(
          width: 55,
          child: Row(
            children: [
              Icon(Icons.cloud_download_outlined,color: Colors.indigo,size: 24,),
              SizedBox(width: 5,),
              Icon(Icons.panorama_fish_eye, color: Colors.green,size: 24,),
            ],
          ),
        )
      ),
    );
  }
}