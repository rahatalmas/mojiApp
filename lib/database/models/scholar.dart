import 'package:json_annotation/json_annotation.dart';

part 'scholar.g.dart';

@JsonSerializable()
class Scholar {
  @JsonKey(name: 'scholar_id')
  final int scholarId;

  @JsonKey(name: 'scholar_name')
  final String scholarName;

  @JsonKey(name: 'scholar_school')
  final String scholarSchool;

  @JsonKey(name: 'class_level')
  final String classLevel;

  @JsonKey(name: 'scholar_picture')
  final String? scholarPicture;

  Scholar({
    required this.scholarId,
    required this.scholarName,
    required this.scholarSchool,
    required this.classLevel,
    this.scholarPicture,
  });

  Scholar.forPost({
    required this.scholarName,
    required this.scholarSchool,
    required this.classLevel,
    this.scholarPicture
  }) : scholarId = 0;

  factory Scholar.fromJson(Map<String, dynamic> json) => _$ScholarFromJson(json);
  //Map<String, dynamic> toJson() => _$ScholarToJson(this);

  Map<String, dynamic> toJson() {
    final data = _$ScholarToJson(this);
    if (scholarId == 0) {
      data.remove('scholar_id'); // Remove `id` if it's a placeholder
    }
    return data;
  }
}

