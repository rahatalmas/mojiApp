import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/result/resultUpdateScreen.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/resultProvider.dart';

class ResultDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> examResult;
  ResultDetailsScreen({super.key, required this.examResult});

  @override
  _ResultDetailsScreen createState() => _ResultDetailsScreen();
}

class _ResultDetailsScreen extends State<ResultDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> examResult = widget.examResult;
    return Scaffold(
      appBar: AppBar(
        title: Text('Results Details'),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () {

            },
            child: Icon(Icons.search),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: brandMinus3,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          examResult['exam_name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: colorPrimary,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("Info tapped");
                        },
                        child: const Icon(
                          Icons.new_releases_outlined,
                          size: 24,
                          color: colorPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.supervisor_account, size: 20, color: colorPrimary),
                          SizedBox(width: 2),
                          Text("candidates: "+examResult['candidate_count'].toString()),
                        ],
                      ),
                      SizedBox(width: 8),
                      Row(
                        children: [
                          Icon(Icons.fact_check_outlined, size: 20, color: colorPrimary),
                          SizedBox(width: 2),
                          Text('Checked: ${examResult['candidates'].length}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 20,
                            color: Colors.green,
                          ),
                          SizedBox(width: 4),
                          Text('Passed: ${examResult['candidates'].length - examResult['fail_count']}'),
                        ],
                      ),
                      SizedBox(width: 8),
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.close,
                                size: 12,
                                color: Colors.white,
                              )),
                          SizedBox(width: 4),
                          Text('Fail: ${examResult['fail_count']}'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [Icon(Icons.list), Text("Results")],
                ),
                Row(
                  children: [Text("filter"), Icon(Icons.arrow_drop_down_outlined, size: 24)],
                ),
              ],
            ),
            SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                itemCount: examResult['candidates'].length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1)
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      child: InkWell(
                        onTap: () {
                          print("Student Result Card");
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Image.asset("assets/images/man.png", width: 90),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              examResult['candidates'][index]['candidate_name'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  overflow: TextOverflow.ellipsis),
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Row(
                                            children: [
                                              Text("Passed", style: TextStyle(color: Colors.green)),
                                              Icon(
                                                Icons.radio_button_checked,
                                                color: Colors.green,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 4),
                                          InkWell(
                                              onTap:(){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultUpdateScreen(
                                                    examId: examResult['exam_id'],
                                                    serialNumber: examResult['candidates'][index]['serial_number'],
                                                    correctAnswers: examResult['candidates'][index]['correct_answers'],
                                                    incorrectAnswers: examResult['candidates'][index]['incorrect_answers'],
                                                    grade: examResult['candidates'][index]['grade']
                                                )));
                                              },
                                              child: Icon(Icons.edit_note)
                                          )
                                        ],
                                      ),
                                      Text('Serial: ${examResult['candidates'][index]['serial_number']}'),
                                      Row(
                                        children: [
                                          Text('Marks: ${examResult['candidates'][index]['correct_answers']}'),
                                          SizedBox(width: 8),
                                          Text('Out Of: ${examResult['question_count']}'),
                                        ],
                                      ),
                                      Text(
                                        'Grade: ${examResult['candidates'][index]['grade']}',
                                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                // Generate and download PDF when the button is clicked
                await _generateAndDownloadPDF();
              },
              child: Ink(
                width: double.maxFinite,
                height: 48,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Download PDF",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Method to generate and download the PDF
// Method to generate and download the PDF
  Future<void> _generateAndDownloadPDF() async {
    try {
      final pdf = pw.Document();

      // Constants for pagination
      const int itemsPerPage = 20; // Number of rows per page
      final List<dynamic> candidates = widget.examResult['candidates'];
      final int totalItems = candidates.length;
      final int totalPages = (totalItems / itemsPerPage).ceil();

      for (int page = 0; page < totalPages; page++) {
        final start = page * itemsPerPage;
        final end = (start + itemsPerPage > totalItems) ? totalItems : start + itemsPerPage;

        // Add a page to the PDF
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Stack(
                children: [
                  // Main content
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Header
                      pw.Text(
                        'Exam Results',
                        style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 20),

                      // Table headers
                      pw.Row(
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              'Serial Number',
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              'Name',
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              'Grade',
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      pw.Divider(),

                      // Table rows for this page
                      ...candidates.sublist(start, end).map<pw.Widget>((candidate) {
                        return pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(candidate['serial_number'].toString()),
                            ),
                            pw.Expanded(
                              child: pw.Text(candidate['candidate_name']),
                            ),
                            pw.Expanded(
                              child: pw.Text(candidate['grade']),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),

                  // Footer (page number)
                  pw.Positioned(
                    bottom: 0, // Align at the bottom of the page
                    left: 0,
                    right: 0,
                    child: pw.Center(
                      child: pw.Text(
                        'Page ${page + 1} of $totalPages',
                        style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }

      // Save PDF to local directory
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/exam_result.pdf");
      await file.writeAsBytes(await pdf.save());

      // Use the printing package to download the file
      await Printing.sharePdf(
        bytes: await file.readAsBytes(),
        filename: 'exam_result.pdf',
      );
    } catch (e) {
      print('Error generating PDF: $e');
    }
  }


}

