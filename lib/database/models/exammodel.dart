import 'package:json_annotation/json_annotation.dart';

part 'exammodel.g.dart';

@JsonSerializable()
class Exam {
  @JsonKey(name: 'exam_id')
  final int id;

  @JsonKey(name: 'exam_name')
  final String name;

  @JsonKey(name: 'exam_date')
  final String dateTime;

  @JsonKey(name: 'exam_location')
  final String location;

  @JsonKey(name: 'exam_duration')
  final int duration;

  @JsonKey(name: 'question_count')
  final int totalQuestions;

  @JsonKey(name: 'candidate_count')
  final int numberOfCandidates;

  // Constructor for fetched data
  Exam({
    required this.id, // Always required for fetched data
    required this.name,
    required this.dateTime,
    required this.location,
    required this.duration,
    required this.totalQuestions,
    required this.numberOfCandidates,
  });

  Exam.forPost({
    required this.name,
    required this.dateTime,
    required this.location,
    required this.duration,
    required this.totalQuestions,
    required this.numberOfCandidates,
  }) : id = 0;

  /// Factory for parsing fetched data from JSON
  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);

  /// Convert instance to JSON for POST request (excludes `id`)
  Map<String, dynamic> toJson() {
    final data = _$ExamToJson(this);
    if (id == 0) {
      data.remove('exam_id'); // Remove `id` if it's a placeholder
    }
    return data;
  }
}
