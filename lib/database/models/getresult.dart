import 'package:json_annotation/json_annotation.dart';

part 'getresult.g.dart';

@JsonSerializable()
class GetResult {
  @JsonKey(name: 'exam_id')
  final int examId;

  @JsonKey(name: 'exam_name')
  final String examName;

  @JsonKey(name: 'exam_date')
  final DateTime examDate;

  @JsonKey(name: 'exam_location')
  final String examLocation;

  @JsonKey(name: 'exam_duration')
  final int examDuration;

  @JsonKey(name: 'question_count')
  final int questionCount;

  @JsonKey(name: 'candidate_count')
  final int candidateCount;

  @JsonKey(name: 'serial_number')
  final int serialNumber;

  @JsonKey(name: 'candidate_name')
  final String candidateName;

  @JsonKey(name: 'school_name')
  final String schoolName;

  @JsonKey(name: 'class_level')
  final String classLevel;

  @JsonKey(name: 'candidate_picture')
  final String? candidatePicture;

  @JsonKey(name: 'scholar_id')
  final int scholarId;

  @JsonKey(name: 'correct_answers')
  final int correctAnswers;

  @JsonKey(name: 'incorrect_answers')
  final int incorrectAnswers;

  @JsonKey(name: 'grade')
  final String grade;

  GetResult({
    required this.examId,
    required this.examName,
    required this.examDate,
    required this.examLocation,
    required this.examDuration,
    required this.questionCount,
    required this.candidateCount,
    required this.serialNumber,
    required this.candidateName,
    required this.schoolName,
    required this.classLevel,
    this.candidatePicture,
    required this.scholarId,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.grade,
  });

  factory GetResult.fromJson(Map<String, dynamic> json) => _$GetResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetResultToJson(this);
}
