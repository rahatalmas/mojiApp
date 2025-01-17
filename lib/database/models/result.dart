import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  @JsonKey(name: 'exam_id')
  final int examId;

  @JsonKey(name: 'serial_number')
  final int serialNumber;

  @JsonKey(name: 'correct_answers')
  final int correctAnswers;

  @JsonKey(name: 'incorrect_answers')
  final int incorrectAnswers;

  @JsonKey(name: 'grade')
  final String grade;

  Result({
    required this.examId,
    required this.serialNumber,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.grade,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
