import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    String? id,
    required String title,
    String? description,
    required bool isFavorite,
    required bool isDone,
  }) = _Todo;
}
