import 'package:assignment4/data/dto/todo_dto.dart';
import 'package:assignment4/logic/entity/todo.dart';

// 매핑을 위한 함수 정의

// DTO > Entity
Todo dtoToEntity(TodoDto dto) {
  return Todo(
    id: dto.id,
    title: dto.title,
    description: dto.description,
    isFavorite: dto.isFavorite,
    isDone: dto.isDone,
    createdAt: dto.createdAt,
  );
}

// Entity > DTO
TodoDto entityToDto(Todo entity) {
  return TodoDto(
    id: entity.id,
    title: entity.title,
    description: entity.description,
    isFavorite: entity.isFavorite,
    isDone: entity.isDone,
    createdAt: entity.createdAt,
  );
}
