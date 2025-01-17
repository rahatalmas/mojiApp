import 'package:flutter/material.dart';
import 'package:quizapp/Screens/exam/examDetailsScreen.dart';
import 'package:quizapp/Screens/exam/examUpdateScreen.dart';
import 'package:quizapp/constant.dart';

class ExamCard extends StatefulWidget {
  final int examId;
  final String examName;
  final DateTime examDate;
  final String examLocation;
  final int examDuration;
  final int questionCount;
  final int candidateCount;
  final VoidCallback onDelete;

  const ExamCard({
    Key? key,
    required this.examId,
    required this.examName,
    required this.examDate,
    required this.examLocation,
    required this.examDuration,
    required this.questionCount,
    required this.candidateCount,
    required this.onDelete,
  }) : super(key: key);

  @override
  _ExamCardState createState() => _ExamCardState();
}

class _ExamCardState extends State<ExamCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: neutralWhite,
      elevation: 3,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: BorderDirectional(bottom: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.new_releases_outlined,size: 20,),
                        SizedBox(width: 2,),
                        Text(
                          'Created on: ${_formatDate(widget.examDate)}',
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateExamScreen(
                                  examId: widget.examId,
                                  examName: widget.examName,
                                  examDateTime: widget.examDate,
                                  examLocation: widget.examLocation,
                                  examDuration: widget.examDuration,
                                  questionCount: widget.questionCount,
                                  candidateCount: widget.candidateCount,
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.edit_note,
                            color: colorPrimary,
                          ),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: widget.onDelete,
                          child: Icon(Icons.delete, color: Colors.red[900]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.examName,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: colorPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: colorPrimary),
                  const SizedBox(width: 8),
                  Text("Date: ${_formatDate(widget.examDate)}"),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: colorPrimary),
                  const SizedBox(width: 8),
                  Text("Location: ${widget.examLocation}"),
                ],
              ),
              if (_isExpanded) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer, size: 16, color: colorPrimary),
                    const SizedBox(width: 8),
                    Text("Duration: ${widget.examDuration} hours"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.help_outline, size: 16, color: colorPrimary),
                    const SizedBox(width: 8),
                    Text("Questions: ${widget.questionCount}"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people, size: 16, color: colorPrimary),
                    const SizedBox(width: 8),
                    Text("Candidates: ${widget.candidateCount}"),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 2,),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                              borderRadius: BorderRadius.circular(1)
                            ),
                          ),
                          SizedBox(width: 4,),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(1)
                            ),
                          ),
                          SizedBox(width: 4,),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(1)
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isExpanded ? "Hide details" : "Show details",
                            style: TextStyle(color: colorPrimary),
                          ),
                          Icon(
                            _isExpanded ? Icons.expand_less : Icons.expand_more,
                            color: colorPrimary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }
}