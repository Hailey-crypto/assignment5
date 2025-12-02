import 'package:assignment4/data/data_source/todo_data_source.dart';
import 'package:assignment4/data/mapper/todo_mapper.dart';
import 'package:assignment4/logic/entity/todo.dart';
import 'package:assignment4/logic/repository/todo_repository.dart';

// Dto - Entity 매핑
class TodoRepositoryImpl implements TodoRepository {
  const TodoRepositoryImpl(this.dataSource); // 의존성 주입
  final TodoDataSource dataSource;

  @override
  Future<List<Todo>> getTodos() async {
    final dtos = await dataSource.getTodos();
    return dtos.map(dtoToEntity).toList();
  }

  @override
  Future<List<Todo>> getMoreTodos(Todo lastTodo) async {
    final dtos = await dataSource.getMoreTodos(entityToDto(lastTodo));
    return dtos.map(dtoToEntity).toList();
  }

  @override
  Future<void> addTodo(Todo todo) async {
    await dataSource.addTodo(entityToDto(todo));
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await dataSource.updateTodo(entityToDto(todo));
  }

  @override
  Future<void> deleteTodo(String id) async {
    await dataSource.deleteTodo(id);
  }
}
