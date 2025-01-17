// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scholar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scholar _$ScholarFromJson(Map<String, dynamic> json) => Scholar(
      scholarId: (json['scholar_id'] as num).toInt(),
      scholarName: json['scholar_name'] as String,
      scholarSchool: json['scholar_school'] as String,
      classLevel: json['class_level'] as String,
      scholarPicture: json['scholar_picture'] as String?,
    );

Map<String, dynamic> _$ScholarToJson(Scholar instance) => <String, dynamic>{
      'scholar_id': instance.scholarId,
      'scholar_name': instance.scholarName,
      'scholar_school': instance.scholarSchool,
      'class_level': instance.classLevel,
      'scholar_picture': instance.scholarPicture,
    };
