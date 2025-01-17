import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/providers/examProvider.dart';

import '../../constant.dart';

class ItemWrapper extends StatelessWidget {

  const ItemWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final examProvider = Provider.of<ExamProvider>(context,listen:true);
    return Center(
      child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/complete2.json",height: 112),
            Text("Registration Complete",style: TextStyle(fontSize:20,color: colorPrimary,fontWeight: FontWeight.w500),),
            Text('Total Candidates: ${examProvider.selectedExam!.totalQuestions}'),
            Text('Exam Date: 20/12/24')
          ],
        )
    );
  }
}
