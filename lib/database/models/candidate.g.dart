// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
      serialNumber: (json['serial_number'] as num).toInt(),
      name: json['candidate_name'] as String,
      schoolName: json['school_name'] as String,
      classLevel: json['class_level'] as String,
      picture: json['candidate_picture'] as String?,
      scholarId: (json['scholar_id'] as num?)?.toInt(),
      examId: (json['exam_id'] as num).toInt(),
    );

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
      'serial_number': instance.serialNumber,
      'candidate_name': instance.name,
      'school_name': instance.schoolName,
      'class_level': instance.classLevel,
      'candidate_picture': instance.picture,
      'scholar_id': instance.scholarId,
      'exam_id': instance.examId,
    };
