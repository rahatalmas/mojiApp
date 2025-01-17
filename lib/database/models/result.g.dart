// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      examId: (json['exam_id'] as num).toInt(),
      serialNumber: (json['serial_number'] as num).toInt(),
      correctAnswers: (json['correct_answers'] as num).toInt(),
      incorrectAnswers: (json['incorrect_answers'] as num).toInt(),
      grade: json['grade'] as String,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'exam_id': instance.examId,
      'serial_number': instance.serialNumber,
      'correct_answers': instance.correctAnswers,
      'incorrect_answers': instance.incorrectAnswers,
      'grade': instance.grade,
    };
