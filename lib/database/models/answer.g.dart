// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      examId: (json['exam_id'] as num).toInt(),
      questionSetId: (json['question_set_id'] as num).toInt(),
      questionNumber: (json['question_number'] as num).toInt(),
      correctAnswer: (json['correct_answer'] as num).toInt(),
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'exam_id': instance.examId,
      'question_set_id': instance.questionSetId,
      'question_number': instance.questionNumber,
      'correct_answer': instance.correctAnswer,
    };
