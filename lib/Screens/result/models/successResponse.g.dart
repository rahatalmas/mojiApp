// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'successResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessResponse _$SuccessResponseFromJson(Map<String, dynamic> json) =>
    SuccessResponse(
      correctAnswers: (json['correct_answers'] as num).toInt(),
      grade: json['grade'] as String,
      incorrectAnswers: (json['incorrect_answers'] as num).toInt(),
      message: json['message'] as String,
      serialNumber: (json['serial_number'] as num).toInt(),
      totalQuestion: (json['total_question'] as num).toInt(),
    );

Map<String, dynamic> _$SuccessResponseToJson(SuccessResponse instance) =>
    <String, dynamic>{
      'correct_answers': instance.correctAnswers,
      'grade': instance.grade,
      'incorrect_answers': instance.incorrectAnswers,
      'message': instance.message,
      'serial_number': instance.serialNumber,
      'total_question': instance.totalQuestion,
    };
