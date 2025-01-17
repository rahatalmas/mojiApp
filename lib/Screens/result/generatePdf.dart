import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

class ExamResultPage extends StatelessWidget {
  final Map<String, dynamic> examResult;

  ExamResultPage({required this.examResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam Results PDF"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _generateAndDownloadPDF();
          },
          child: Text("Download PDF"),
        ),
      ),
    );
  }

  // Method to generate and download the PDF
  Future<void> _generateAndDownloadPDF() async {
    final pdf = pw.Document();

    // Add a page to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Exam Results', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              // Table headers
              pw.Row(
                children: [
                  pw.Expanded(child: pw.Text('Serial Number', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Expanded(child: pw.Text('Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Expanded(child: pw.Text('School', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Expanded(child: pw.Text('Grade', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                ],
              ),
              pw.SizedBox(height: 10),
              // Table rows
              ...examResult['candidates'].map<pw.Widget>((candidate) {
                return pw.Row(
                  children: [
                    pw.Expanded(child: pw.Text(candidate['serial_number'].toString())),
                    pw.Expanded(child: pw.Text(candidate['candidate_name'])),
                    pw.Expanded(child: pw.Text(candidate['school'] ?? 'N/A')),
                    pw.Expanded(child: pw.Text(candidate['grade'])),
                  ],
                );
              }).toList(),
            ],
          );
        },
      ),
    );

    // Save PDF to local directory
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/exam_result.pdf");
    await file.writeAsBytes(await pdf.save());

    // Use the printing package to download the file
    Printing.sharePdf(bytes: await file.readAsBytes(), filename: 'exam_result.pdf');
  }
}
