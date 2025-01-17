// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examdetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamResponse _$ExamResponseFromJson(Map<String, dynamic> json) => ExamResponse(
      exam_id: (json['exam_id'] as num?)?.toInt(),
      exam_name: json['exam_name'] as String?,
      exam_date: json['exam_date'] as String?,
      exam_location: json['exam_location'] as String?,
      exam_duration: (json['exam_duration'] as num?)?.toInt(),
      question_count: (json['question_count'] as num?)?.toInt(),
      candidate_count: (json['candidate_count'] as num?)?.toInt(),
      serial_number: (json['serial_number'] as num?)?.toInt(),
      candidate_name: json['candidate_name'] as String?,
      candidate_school: json['candidate_school'] as String?,
      candidate_class_level: json['candidate_class_level'] as String?,
      candidate_picture: json['candidate_picture'] as String?,
      scholar_id: (json['scholar_id'] as num?)?.toInt(),
      question_number: (json['question_number'] as num?)?.toInt(),
      correct_answer: (json['correct_answer'] as num?)?.toInt(),
      correct_answers: (json['correct_answers'] as num?)?.toInt(),
      incorrect_answers: (json['incorrect_answers'] as num?)?.toInt(),
      grade: json['grade'] as String?,
    );

Map<String, dynamic> _$ExamResponseToJson(ExamResponse instance) =>
    <String, dynamic>{
      'exam_id': instance.exam_id,
      'exam_name': instance.exam_name,
      'exam_date': instance.exam_date,
      'exam_location': instance.exam_location,
      'exam_duration': instance.exam_duration,
      'question_count': instance.question_count,
      'candidate_count': instance.candidate_count,
      'serial_number': instance.serial_number,
      'candidate_name': instance.candidate_name,
      'candidate_school': instance.candidate_school,
      'candidate_class_level': instance.candidate_class_level,
      'candidate_picture': instance.candidate_picture,
      'scholar_id': instance.scholar_id,
      'question_number': instance.question_number,
      'correct_answer': instance.correct_answer,
      'correct_answers': instance.correct_answers,
      'incorrect_answers': instance.incorrect_answers,
      'grade': instance.grade,
    };
