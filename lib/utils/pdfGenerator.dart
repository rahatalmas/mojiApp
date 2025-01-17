import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:quizapp/providers/questionProvider.dart';

class PdfGenerator {
  static Future<void> generatePdf(BuildContext context) async {
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);

    final pdf = pw.Document();
    const questionsPerPage = 30; // Total questions per page
    const leftColumnQuestions = 15; // Questions in the left column
    const rightColumnQuestions = 15; // Questions in the right column
    int currentQuestionIndex = 0;

    while (currentQuestionIndex < questionProvider.questions.length) {
      final remainingQuestions = questionProvider.questions.skip(currentQuestionIndex).toList();
      final currentQuestions = remainingQuestions.take(questionsPerPage).toList();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Adjust margins for balance
          build: (pw.Context context) {
            return [
              pw.Align(
                alignment: pw.Alignment.topCenter, // Align title to top-center
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Quiz Questions',
                      style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      'Total question ${questionProvider.questions.length}',
                      style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ]
                )
              ),
              pw.SizedBox(height: 12),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: List.generate(
                        leftColumnQuestions,
                            (index) {
                          if (index < currentQuestions.length) {
                            final question = currentQuestions[index];
                            return _buildQuestion(index + 1, question);
                          }
                          return pw.SizedBox();
                        },
                      ),
                    ),
                  ),
                  pw.SizedBox(width: 12), // Adjust space between columns
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: List.generate(
                        rightColumnQuestions,
                            (index) {
                          final nextIndex = index + leftColumnQuestions;
                          if (nextIndex < currentQuestions.length) {
                            final question = currentQuestions[nextIndex];
                            return _buildQuestion(nextIndex + 1, question);
                          }
                          return pw.SizedBox();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ];
          },
        ),
      );

      currentQuestionIndex += questionsPerPage;
    }

    // Save the PDF to a temporary directory
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/quiz_questions.pdf");
    await file.writeAsBytes(await pdf.save());

    print("PDF saved at: ${file.path}");
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  static pw.Widget _buildQuestion(int questionNumber, dynamic question) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 4), // Reduced margin between questions
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            '$questionNumber. ${question.questionText}',
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold), // Further reduced font size
          ),
          pw.SizedBox(height: 2), // Reduced space between question and options
          ...question.options.asMap().entries.map((entry) {
            final int optionIndex = entry.key;
            final option = entry.value;
            return pw.Text(
              '${String.fromCharCode(65 + optionIndex)}: $option',
              style: pw.TextStyle(fontSize: 6), // Further reduced font size for options
            );
          }).toList(),
          pw.SizedBox(height: 2), // Reduced space after options
        ],
      ),
    );
  }
}
