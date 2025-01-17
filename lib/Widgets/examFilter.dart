import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/answerProvider.dart';
import 'package:quizapp/providers/candidateProvider.dart';
import 'package:quizapp/providers/examProvider.dart';
import 'package:quizapp/providers/scholarProvider.dart';
import '../database/models/exammodel.dart';

class ExamFilterWidget extends StatefulWidget {

  const ExamFilterWidget({
    super.key,
  });

  @override
  State<ExamFilterWidget> createState() => _ExamFilterWidgetState();
}

class _ExamFilterWidgetState extends State<ExamFilterWidget> {
  //late ExamProvider _examProvider;

  // @override
  // void initState(){
  //   super.initState();
  //   _examProvider = context.watch<ExamProvider>();
  //   _examProvider.getAllExams();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _examProvider = context.watch<ExamProvider>();
  //   if (!_examProvider.dataUpdated) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       _examProvider.getAllExams();
  //     });
  //   }
  // }

  void _showExamFilterModal(BuildContext context) async {
    final candidateProvider = Provider.of<CandidateProvider>(context, listen: false);
    final scholarProvider = Provider.of<ScholarProvider>(context, listen: false);
    final answerProvider = Provider.of<AnswerProvider>(context, listen: false);
    final examProvider = Provider.of<ExamProvider>(context, listen: false);

    examProvider.getAllExams();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Exam List",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Consumer<ExamProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return Center(
                          child: Lottie.asset("assets/images/loader.json",width: 112)
                        );
                      }

                      if (provider.exams.isEmpty) {
                        return const Center(
                          child: Text("No exams available."),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: provider.exams.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final exam = provider.exams[index];
                          return ListTile(
                            title: Text(exam.name),
                            subtitle: Text(
                              "Date: ${exam.dateTime}, Location: ${exam.location}",
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              provider.setSelectedExam(exam);
                              candidateProvider.getAllCandidates(exam.id);
                              scholarProvider.getFilteredScholars(exam.id);
                              answerProvider.getAllAnswers(exam.id);
                              Navigator.pop(context); // Close the modal
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final examProvider = Provider.of<ExamProvider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showExamFilterModal(context),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //border: Border.all(color: Colors.black12),
                color: neutralBG),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  examProvider.selectedExam == null ? "Select Exam" : examProvider.selectedExam!.name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorPrimary),
                ),
                SvgPicture.asset(
                  "assets/images/filter.svg",
                  height: 20,
                  color: colorPrimary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
