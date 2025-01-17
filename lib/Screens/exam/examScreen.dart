import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/exam/examCreatePage.dart';
import 'package:quizapp/Widgets/examCard.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/examProvider.dart';
import 'package:quizapp/providers/resultProvider.dart';

class ExamScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late ExamProvider _examProvider;

  // @override
  // void initState(){
  //   super.initState();
  //   _examProvider = context.watch<ExamProvider>();
  //   _examProvider.getAllExams();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _examProvider = context.watch<ExamProvider>();
    if (!_examProvider.dataUpdated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _examProvider.getAllExams();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exams'),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: neutralWhite,
        actions: [
          InkWell(
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExamCreatePage()),
                  ),
              child: Icon(Icons.add)),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      backgroundColor: neutralWhite,
      body: Center(
        child: _examProvider.isLoading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/images/animations/geometryloader.json", height: 125),
                ],
              )
            : _examProvider.message.isNotEmpty
                ? Text(_examProvider.message)
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [SizedBox(width: 1,),Icon(Icons.list), Text("List Exams")],
                            ),
                            Row(
                              children: [
                                Text("All"),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _examProvider.exams.length,
                            itemBuilder: (context, index) {
                              final exam = _examProvider.exams[index];
                              return ExamCard(
                                examId: exam.id,
                                examName: exam.name,
                                examDate: DateTime.parse(exam.dateTime),
                                examLocation: exam.location,
                                examDuration: exam.duration,
                                questionCount: exam.totalQuestions,
                                candidateCount: exam.numberOfCandidates,
                                onDelete: () async {
                                  bool res = await _examProvider.deleteExam(exam.id);
                                  if(res){
                                    Provider.of<ResultProvider>(context,listen: false).getAllResults();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ExamCreatePage()));
                          },
                          child: Ink(
                            width: double.maxFinite,
                            height: 48,
                            decoration: BoxDecoration(
                                color: colorPrimary,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Add New",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
