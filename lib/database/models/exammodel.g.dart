// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exammodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exam _$ExamFromJson(Map<String, dynamic> json) => Exam(
      id: (json['exam_id'] as num).toInt(),
      name: json['exam_name'] as String,
      dateTime: json['exam_date'] as String,
      location: json['exam_location'] as String,
      duration: (json['exam_duration'] as num).toInt(),
      totalQuestions: (json['question_count'] as num).toInt(),
      numberOfCandidates: (json['candidate_count'] as num).toInt(),
    );

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
      'exam_id': instance.id,
      'exam_name': instance.name,
      'exam_date': instance.dateTime,
      'exam_location': instance.location,
      'exam_duration': instance.duration,
      'question_count': instance.totalQuestions,
      'candidate_count': instance.numberOfCandidates,
    };
