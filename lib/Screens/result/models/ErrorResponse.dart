import 'package:json_annotation/json_annotation.dart';

part 'ErrorResponse.g.dart';


@JsonSerializable()
class ErrorResponse {
  final String message;

  @JsonKey(name: 'serial_number')
  final int serialNumber;

  ErrorResponse({
    required this.message,
    required this.serialNumber,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
