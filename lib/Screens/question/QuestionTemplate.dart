import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/questionProvider.dart';

import '../../utils/pdfGenerator.dart';

class QuestionTemplate extends StatelessWidget {
  const QuestionTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(
      builder: (context, questionProvider, child) {
        // Check if there are questions
        if (questionProvider.questions.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/images/animations/emptybox.json"),
                Text("Nothing to preview")
              ],
            ),
          );
        }

        return Column(
          children: [
            // Top Container (Always at the top)
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: brandMinus3,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Colors.green, borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Total: ${questionProvider.questions.length}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      questionProvider.resetQuestions();
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            'Reset',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
                          ),
                          Icon(Icons.delete_outline_outlined, color: Colors.red),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded section for the list of questions (scrollable)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    questionProvider.questions.length,
                        (index) {
                      final question = questionProvider.questions[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Q${index + 1}: ${question.questionText}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              ...question.options.asMap().entries.map((entry) {
                                final optionIndex = entry.key;
                                final option = entry.value;
                                return Text(
                                  'Option ${String.fromCharCode(65 + optionIndex)}: $option',
                                  style: const TextStyle(fontSize: 14),
                                );
                              }),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: InkWell(
                                      onTap: () {
                                        _editQuestion(context, questionProvider, index);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: colorPrimary),
                                          borderRadius: BorderRadius.circular(10),
                                          color: brandMinus2,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(color: colorPrimary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10), // Space between the buttons
                                  Flexible(
                                    child: InkWell(
                                      onTap: () {
                                        questionProvider.removeQuestion(index);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.red),
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.red[100],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Remove',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Bottom button (Always at the bottom)
            SizedBox(
              width: double.infinity, // Make button take full width
              child: InkWell(
                onTap: () {
                  PdfGenerator.generatePdf(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Generate PDF',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editQuestion(BuildContext context, QuestionProvider questionProvider, int index) {
    final question = questionProvider.questions[index];
    final TextEditingController questionController =
    TextEditingController(text: question.questionText);
    final List<TextEditingController> optionControllers =
    question.options.map((option) => TextEditingController(text: option)).toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Question'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: questionController,
                  decoration: const InputDecoration(labelText: 'Question Text'),
                ),
                const SizedBox(height: 10),
                ...optionControllers.asMap().entries.map((entry) {
                  final optionIndex = entry.key;
                  final controller = entry.value;
                  return TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Option ${String.fromCharCode(65 + optionIndex)}',
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                final updatedQuestion = question.copyWith(
                  questionText: questionController.text,
                  options: optionControllers.map((controller) => controller.text).toList(),
                );
                questionProvider.editQuestion(index, updatedQuestion);
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
