import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/exammodel.dart';
import 'package:quizapp/providers/examProvider.dart';

class UpdateExamScreen extends StatefulWidget {
  final int examId;
  final String examName;
  final DateTime examDateTime;
  final String examLocation;
  final int examDuration;
  final int questionCount;
  final int candidateCount;

  const UpdateExamScreen({
    super.key,
    required this.examId,
    required this.examName,
    required this.examDateTime,
    required this.examLocation,
    required this.examDuration,
    required this.questionCount,
    required this.candidateCount,
  });

  @override
  State<UpdateExamScreen> createState() => _UpdateExamScreenState();
}

class _UpdateExamScreenState extends State<UpdateExamScreen> {
  late ExamProvider _examProvider;
  late TextEditingController _examNameController;
  late TextEditingController _examDateController;
  late TextEditingController _examLocationController;
  late TextEditingController _examDurationController;
  late TextEditingController _questionCountController;
  late TextEditingController _candidateCountController;

  final InputDecoration _textFieldDecoration = InputDecoration(
    labelText: "Type here...",
    hintText: "Enter value",
    hintStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(color: Colors.black),
    prefixIcon: Padding(
      padding: const EdgeInsets.only(left: 15, right: 5),
      child: Icon(Icons.input, size: 30, color: kColorPrimary),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
    ),
    fillColor: Colors.white,
    filled: true,
  );

  @override
  void initState() {
    super.initState();
    _examProvider = Provider.of<ExamProvider>(context, listen: false);

    // Initialize controllers with the passed-in values
    _examNameController = TextEditingController(text: widget.examName);
    _examDateController = TextEditingController(text: widget.examDateTime.toString());
    _examLocationController = TextEditingController(text: widget.examLocation);
    _examDurationController = TextEditingController(text: widget.examDuration.toString());
    _questionCountController = TextEditingController(text: widget.questionCount.toString());
    _candidateCountController = TextEditingController(text: widget.candidateCount.toString());
  }

  @override
  void dispose() {
    _examNameController.dispose();
    _examDateController.dispose();
    _examLocationController.dispose();
    _examDurationController.dispose();
    _questionCountController.dispose();
    _candidateCountController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime fullDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        setState(() {
          _examDateController.text = fullDateTime.toIso8601String();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
    KeyboardVisibilityProvider.isKeyboardVisible(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Exam",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: neutralWhite,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 3,
        shadowColor: Colors.grey,
      ),
      backgroundColor: neutralWhite,
      body:
      _examProvider.isLoading?Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/animations/geometryloader.json", height: 125),
          ],
        ),
      ):
      Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/exam.png",
                      height: 250,
                      width: 250,
                    )
                  ],
                ),
                SizedBox(height: 16),
                // Exam Name Field
                TextField(
                  controller: _examNameController,
                  decoration: _textFieldDecoration.copyWith(
                      labelText: "Exam Name",
                      hintText: "Enter exam name",
                      prefixIcon: Icon(
                        Icons.terminal_sharp,
                        size: 25,
                      )),
                ),
                const SizedBox(height: 10),
                // Exam Date Field with DateTime Picker
                GestureDetector(
                  onTap: _selectDateTime,
                  child: AbsorbPointer(
                    child: TextField(
                      controller: _examDateController,
                      decoration: _textFieldDecoration.copyWith(
                        labelText: "Exam Date & Time",
                        hintText: "Select date and time",
                        prefixIcon: const Icon(
                          Icons.calendar_today,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Exam Location Field
                TextField(
                  controller: _examLocationController,
                  decoration: _textFieldDecoration.copyWith(
                      labelText: "Exam Location",
                      hintText: "e.g., School Auditorium",
                      prefixIcon: const Icon(Icons.location_on_outlined)),
                ),
                const SizedBox(height: 10),
                // Last Three Fields in a Row
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _examDurationController,
                        keyboardType: TextInputType.number,
                        decoration: _textFieldDecoration.copyWith(
                            labelText: "Duration (min)",
                            hintText: "e.g., 90",
                            prefixIcon: const Icon(Icons.timer)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _questionCountController,
                        keyboardType: TextInputType.number,
                        decoration: _textFieldDecoration.copyWith(
                            labelText: "Questions",
                            hintText: "e.g., 50",
                            prefixIcon: const Icon(Icons.numbers)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _candidateCountController,
                        keyboardType: TextInputType.number,
                        decoration: _textFieldDecoration.copyWith(
                            labelText: "Candidates",
                            hintText: "e.g., 100",
                            prefixIcon: const Icon(Icons.numbers)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () async {
                    print("Updated Exam Details:");
                    print("Name: ${_examNameController.text}");
                    print("DateTime: ${_examDateController.text}");
                    print("Location: ${_examLocationController.text}");
                    print("Duration: ${_examDurationController.text}");
                    print("Questions: ${_questionCountController.text}");
                    print("Candidates: ${_candidateCountController.text}");

                    Exam updatedExam = Exam(
                      id: widget.examId,
                      name: _examNameController.text,
                      dateTime: _examDateController.text,
                      location: _examLocationController.text,
                      duration: int.parse(_examDurationController.text),
                      totalQuestions: int.parse(_questionCountController.text),
                      numberOfCandidates: int.parse(_candidateCountController.text),
                    );
                     bool isSuccess = await _examProvider.updateExam(updatedExam);

                    if (isSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration.zero,
                          content: Text('Exam updated successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration.zero,
                          content: Text('Failed to update exam'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Update",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
