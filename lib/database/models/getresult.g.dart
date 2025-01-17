// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getresult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetResult _$GetResultFromJson(Map<String, dynamic> json) => GetResult(
      examId: (json['exam_id'] as num).toInt(),
      examName: json['exam_name'] as String,
      examDate: DateTime.parse(json['exam_date'] as String),
      examLocation: json['exam_location'] as String,
      examDuration: (json['exam_duration'] as num).toInt(),
      questionCount: (json['question_count'] as num).toInt(),
      candidateCount: (json['candidate_count'] as num).toInt(),
      serialNumber: (json['serial_number'] as num).toInt(),
      candidateName: json['candidate_name'] as String,
      schoolName: json['school_name'] as String,
      classLevel: json['class_level'] as String,
      candidatePicture: json['candidate_picture'] as String?,
      scholarId: (json['scholar_id'] as num).toInt(),
      correctAnswers: (json['correct_answers'] as num).toInt(),
      incorrectAnswers: (json['incorrect_answers'] as num).toInt(),
      grade: json['grade'] as String,
    );

Map<String, dynamic> _$GetResultToJson(GetResult instance) => <String, dynamic>{
      'exam_id': instance.examId,
      'exam_name': instance.examName,
      'exam_date': instance.examDate.toIso8601String(),
      'exam_location': instance.examLocation,
      'exam_duration': instance.examDuration,
      'question_count': instance.questionCount,
      'candidate_count': instance.candidateCount,
      'serial_number': instance.serialNumber,
      'candidate_name': instance.candidateName,
      'school_name': instance.schoolName,
      'class_level': instance.classLevel,
      'candidate_picture': instance.candidatePicture,
      'scholar_id': instance.scholarId,
      'correct_answers': instance.correctAnswers,
      'incorrect_answers': instance.incorrectAnswers,
      'grade': instance.grade,
    };
