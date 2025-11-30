import 'package:assignment4/data/dto/todo_dto.dart';

abstract interface class TodoDataSource {
  Future<List<TodoDto>> getTodos();
  Future<void> addTodo(TodoDto todo);
  Future<void> updateTodo(TodoDto todo);
  Future<void> deleteTodo(String id);
}
