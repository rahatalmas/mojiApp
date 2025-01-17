import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OmrOptions extends pw.StatelessWidget {
  OmrOptions({
    this.totalOptionCount = 4,
    required this.value,
    this.isSingle = false,
  });

  final int totalOptionCount;
  final String value;
  final bool isSingle;

  @override
  pw.Widget build(pw.Context context) {
    return isSingle
        ? pw.Container(
      height: 10,
      width: 10,
      alignment: pw.Alignment.center,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        border:
        pw.Border.all(color: PdfColor.fromHex('#000000'), width: 1),
      ),
      child: pw.Center(
        child: pw.Text(value, style: const pw.TextStyle(fontSize: 6)),
      ),
    )
        : pw.Row(
      children: [
        pw.Container(
          height: 10,
          width: 10,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            border: pw.Border.all(
                color: PdfColor.fromHex('#000000'), width: 1),
          ),
          child: pw.Center(
            child: pw.Text(value, style: pw.TextStyle(fontSize: 6)),
          ),
        ),
        pw.SizedBox(width: 5),
        pw.Container(
          height: 10,
          width: 10,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            border: pw.Border.all(
                color: PdfColor.fromHex('#000000'), width: 1),
          ),
          child: pw.Center(
            child: pw.Text(value, style: pw.TextStyle(fontSize: 6)),
          ),
        ),
        pw.SizedBox(width: 5),
        pw.Container(
          height: 10,
          width: 10,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            border: pw.Border.all(
                color: PdfColor.fromHex('#000000'), width: 1),
          ),
          child: pw.Center(
            child: pw.Text(value, style: pw.TextStyle(fontSize: 5)),
          ),
        ),
        pw.SizedBox(width: 5),
        pw.Container(
          height: 10,
          width: 10,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            border: pw.Border.all(
                color: PdfColor.fromHex('#000000'), width: 1),
          ),
          child: pw.Center(
            child: pw.Text(value, style: pw.TextStyle(fontSize: 5)),
          ),
        ),
      ],
    );
  }
}
