import 'package:freezed_annotation/freezed_annotation.dart';

part 'to_do_model.freezed.dart';
part 'to_do_model.g.dart';

@freezed
abstract class ToDoModel with _$ToDoModel {
  const factory ToDoModel({
    String? id,
    required String title,
    required String? description,
    @JsonKey(name: 'is_favorite') required bool isFavorite,
    @JsonKey(name: 'is_done') required bool isDone,
  }) = _ToDoModel;

  factory ToDoModel.fromJson(Map<String, Object?> json) =>
      _$ToDoModelFromJson(json);
}
