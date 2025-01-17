import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:quizapp/pdf/widgets/omr_options.dart';
import 'package:collection/collection.dart';

List<String> _omrCircleData = ['A', 'B', 'C', 'D'];

Future<Uint8List> getDocumentBytes(
  pw.Document document,
) async {
  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (ctx) {
        return [
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              // / color: PdfColor.fromHex("000000"),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      margin: const pw.EdgeInsets.all(5),
                      // color: PdfColor.fromHex("83979d"),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Row(
                              children: [
                                pw.Text("Exam Id",
                                    textAlign: pw.TextAlign.start,style: pw.TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Column(
                            children: [
                              ...List.generate(10, (index) {
                                return pw.Column(children: [
                                  OmrOptions(
                                      totalOptionCount: 4,
                                      value: index.toString()),
                                  pw.SizedBox(height: 10),
                                ]);
                              }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  pw.VerticalDivider(endIndent: 18, indent: 30),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      margin: const pw.EdgeInsets.all(5),
                      // color: PdfColor.fromHex("83979d"),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Row(
                              children: [
                                pw.Text("Serial Number",
                                    textAlign: pw.TextAlign.start,style: pw.TextStyle(fontSize: 10)),
                                pw.Text(
                                  "",
                                  textAlign: pw.TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Column(
                            children: [
                              ...List.generate(10, (index) {
                                return pw.Column(children: [
                                  OmrOptions(
                                      totalOptionCount: 4,
                                      value: index.toString()),
                                  pw.SizedBox(height: 10),
                                ]);
                              }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(),
                  ),
                ],
              ),
            ),
          ),
          pw.Expanded(
            flex: 0,
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColor.fromHex("000000"),
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Container(
              child: pw.Row(
                children: [
                  pw.Expanded(
                      child: pw.Container(
                    margin:
                        const pw.EdgeInsets.only(top: 9, right: 9, bottom: 9),
                    child: pw.Column(
                      children: [
                        ...List.generate(20, (index) {
                          return pw.Column(children: [
                            pw.SizedBox(height: 8.38),
                            pw.Row(children: [
                              pw.Container(
                                height: 15,
                                width: 15,
                                child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Align(
                                    child: pw.Text((index + 1).toString()),
                                    alignment: pw.Alignment.centerRight,
                                  ),
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              ..._omrCircleData.mapIndexed((index, e) {
                                return pw.Row(
                                  children: [
                                    OmrOptions(
                                      totalOptionCount: 4,
                                      value: e,
                                      isSingle: true,
                                    ),
                                    if (index < 5) pw.SizedBox(width: 8)
                                  ],
                                );
                              })
                            ]),
                          ]);
                        }),
                      ],
                    ),
                  )),
                  pw.Expanded(
                      child: pw.Container(
                    margin:
                        const pw.EdgeInsets.only(top: 9, right: 9, bottom: 9),
                    child: pw.Column(
                      children: [
                        ...List.generate(20, (index) {
                          return pw.Column(children: [
                            pw.SizedBox(height: 8.38),
                            pw.Row(children: [
                              pw.Container(
                                height: 15,
                                width: 15,
                                child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Align(
                                    child: pw.Text((index + 21).toString()),
                                    alignment: pw.Alignment.centerRight,
                                  ),
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              ..._omrCircleData.mapIndexed((index, e) {
                                return pw.Row(
                                  children: [
                                    OmrOptions(
                                      totalOptionCount: 4,
                                      value: e,
                                      isSingle: true,
                                    ),
                                    if (index < 5) pw.SizedBox(width: 8)
                                  ],
                                );
                              })
                            ]),
                          ]);
                        }),
                      ],
                    ),
                  )),
                  pw.Expanded(
                      child: pw.Container(
                    margin:
                        const pw.EdgeInsets.only(top: 9, right: 9, bottom: 9),
                    child: pw.Column(
                      children: [
                        ...List.generate(20, (index) {
                          return pw.Column(children: [
                            pw.SizedBox(height: 8.38),
                            pw.Row(children: [
                              pw.Container(
                                height: 15,
                                width: 15,
                                child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Align(
                                    child: pw.Text((index + 41).toString()),
                                    alignment: pw.Alignment.centerRight,
                                  ),
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              ..._omrCircleData.mapIndexed((index, e) {
                                return pw.Row(
                                  children: [
                                    OmrOptions(
                                      totalOptionCount: 4,
                                      value: e,
                                      isSingle: true,
                                    ),
                                    if (index < 5) pw.SizedBox(width: 8)
                                  ],
                                );
                              })
                            ]),
                          ]);
                        }),
                      ],
                    ),
                  )),
                  pw.Expanded(
                      child: pw.Container(
                    margin:
                        const pw.EdgeInsets.only(top: 9, right: 9, bottom: 9),
                    child: pw.Column(
                      children: [
                        ...List.generate(20, (index) {
                          return pw.Column(children: [
                            pw.SizedBox(height: 8.38),
                            pw.Row(children: [
                              pw.Container(
                                height: 15,
                                width: 15,
                                child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Align(
                                    child: pw.Text((index + 61).toString()),
                                    alignment: pw.Alignment.centerRight,
                                  ),
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              ..._omrCircleData.mapIndexed((index, e) {
                                return pw.Row(
                                  children: [
                                    OmrOptions(
                                      totalOptionCount: 4,
                                      value: e,
                                      isSingle: true,
                                    ),
                                    if (index < 5) pw.SizedBox(width: 8)
                                  ],
                                );
                              })
                            ]),
                          ]);
                        }),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ];
      },
    ),
  );
  return document.save();
}

Future<Uint8List> generateDocument() async {
  Uint8List? bytes;
  final document = pw.Document();
  try {
    bytes = await getDocumentBytes(document);
  } catch (e) {
    debugPrint(e.toString());
  }
  return bytes ?? Uint8List.fromList([]);
}

class ViewDocument extends StatefulWidget {
  const ViewDocument({super.key});

  @override
  State<ViewDocument> createState() => _ViewDocumentState();
}

class _ViewDocumentState extends State<ViewDocument> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PdfPreview(
            build: (_) => generateDocument(),
          ),
        )
      ],
    );
  }
}
