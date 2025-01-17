import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import '../../database/models/question.dart';
import '../../providers/questionProvider.dart';

class QuestionEditor extends StatefulWidget {
  const QuestionEditor({super.key});

  @override
  State<QuestionEditor> createState() => _QuestionEditorState();
}

class _QuestionEditorState extends State<QuestionEditor> {
  final TextEditingController _questionController = TextEditingController();
  List<TextEditingController> _optionControllers = [];
  int optionsPerQuestion = 4; // Default options per question

  final InputDecoration _textFieldDecoration = InputDecoration(
    labelText: "Type here...",
    hintText: "Enter value",
    hintStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(color: Colors.black),
    prefixIcon: const Icon(Icons.input, size: 30, color: Colors.blue),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.grey, width: 2.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.grey, width: 2.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.blue, width: 2.5),
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
    _initializeOptionControllers();
  }

  void _initializeOptionControllers() {
    _optionControllers =
        List.generate(optionsPerQuestion, (_) => TextEditingController());
  }

  void _addQuestion() {

    final qProvider= Provider.of<QuestionProvider>(context, listen: false);
    if(qProvider.questions.length == 80){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('80 questions filled')),
      );
      return;
    }
    final questionText = _questionController.text;
    final options =
    _optionControllers.map((controller) => controller.text).toList();

    if (questionText.isEmpty || options.any((option) => option.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill in all fields before adding a question.')),
      );
      return;
    }

    // Create a new Question object
    final newQuestion = Question(
      questionText: questionText,
      options: options,
    );


    qProvider.addQuestion(newQuestion);

    // Reset the fields
    _questionController.clear();
    for (var controller in _optionControllers) {
      controller.clear();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Question added successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final qProvider= Provider.of<QuestionProvider>(context, listen: true);
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Container(
           padding: EdgeInsets.symmetric(vertical:0,horizontal: 10),
          decoration: BoxDecoration(
            color: brandMinus3,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      SizedBox(width: 4,),
                      const Text(
                        "Add a Question",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      SizedBox(width: 4,),
                      Text(
                        'Last Index: ${qProvider.questions.length}',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset("assets/images/leading2.png",height: 100,width: 100,),

            ],
          ),
        ),

        const SizedBox(height: 16),
        TextField(
          controller: _questionController,
          decoration: _textFieldDecoration.copyWith(
            labelText: "Question",
            hintText: "Type your question here",
            prefixIcon: const Icon(Icons.question_mark,
                size: 24, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Options",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        for (int i = 0; i < optionsPerQuestion; i++) ...[
          TextField(
            controller: _optionControllers[i],
            decoration: _textFieldDecoration.copyWith(
              labelText: "Option ${String.fromCharCode(65 + i)}",
              hintText: "Enter option ${String.fromCharCode(65 + i)}",
              prefixIcon: Icon(Icons.circle, size: 16, color: Colors.grey[800]),
            ),
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 20),
        InkWell(
          onTap: _addQuestion,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                "Add Question",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
