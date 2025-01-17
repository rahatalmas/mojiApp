import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
  @JsonKey(name: 'exam_id')
  final int examId;

  @JsonKey(name: 'question_set_id')
  final int questionSetId;

  @JsonKey(name: 'question_number')
  final int questionNumber;

  @JsonKey(name: 'correct_answer')
  final int correctAnswer;

  Answer({
    required this.examId,
    required this.questionSetId,
    required this.questionNumber,
    required this.correctAnswer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

}
