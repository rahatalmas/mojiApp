import 'package:json_annotation/json_annotation.dart';

part 'successResponse.g.dart';

@JsonSerializable()
class SuccessResponse {
  @JsonKey(name: 'correct_answers') // Mapping snake_case to camelCase
  final int correctAnswers;

  final String grade;

  @JsonKey(name: 'incorrect_answers') // Mapping snake_case to camelCase
  final int incorrectAnswers;

  final String message;

  @JsonKey(name: 'serial_number') // Mapping snake_case to camelCase
  final int serialNumber;

  @JsonKey(name: 'total_question') // Mapping snake_case to camelCase
  final int totalQuestion;

  SuccessResponse({
    required this.correctAnswers,
    required this.grade,
    required this.incorrectAnswers,
    required this.message,
    required this.serialNumber,
    required this.totalQuestion,
  });

  // From JSON
  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$SuccessResponseFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$SuccessResponseToJson(this);
}
