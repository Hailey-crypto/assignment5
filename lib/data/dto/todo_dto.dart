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
  }) = _TodoDto;

  factory TodoDto.fromJson(Map<String, Object?> json) =>
      _$TodoDtoFromJson(json);
}
