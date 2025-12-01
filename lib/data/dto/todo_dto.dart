import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_dto.freezed.dart';
part 'todo_dto.g.dart';

@freezed
abstract class TodoDto with _$TodoDto {
  const factory TodoDto({
    String? id,
    required String title,
    required String? description,
    @JsonKey(name: 'is_favorite') required bool isFavorite,
    @JsonKey(name: 'is_done') required bool isDone,
    @JsonKey(
      name: 'created_at',
      fromJson: _convertToDateTime,
      toJson: _convertFromDateTime,
    )
    required DateTime createdAt,
  }) = _TodoDto;

  factory TodoDto.fromJson(Map<String, Object?> json) =>
      _$TodoDtoFromJson(json);
}

// DateTime 변환 함수
DateTime _convertToDateTime(String timeString) => DateTime.parse(timeString);
String _convertFromDateTime(DateTime time) => time.toIso8601String();
