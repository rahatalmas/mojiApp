import 'package:json_annotation/json_annotation.dart';

part 'candidate.g.dart';

@JsonSerializable()
class Candidate {
  @JsonKey(name: 'serial_number')
  final int serialNumber;

  @JsonKey(name: 'candidate_name')
  final String name;

  @JsonKey(name: 'school_name')
  final String schoolName;

  @JsonKey(name: 'class_level')
  final String classLevel;

  @JsonKey(name: 'candidate_picture')
  final String? picture;

  @JsonKey(name:'scholar_id')
  final int? scholarId;

  @JsonKey(name: 'exam_id')
  final int examId;

  Candidate({
    required this.serialNumber,
    required this.name,
    required this.schoolName,
    required this.classLevel,
    this.picture,
    this.scholarId,
    required this.examId
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => _$CandidateFromJson(json);

  Map<String, dynamic> toJson() {
    final data = _$CandidateToJson(this);
    return data;
  }
}

