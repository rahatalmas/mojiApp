class Question {
  final String questionText;
  final List<String> options;

  Question({
    required this.questionText,
    required this.options,
  });

  Question copyWith({
    String? questionText,
    List<String>? options,
  }) {
    return Question(
      questionText: questionText ?? this.questionText,
      options: options ?? this.options,
    );
  }
}
