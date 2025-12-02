import 'package:assignment4/logic/entity/todo.dart';
import 'package:assignment4/logic/repository/todo_repository.dart';

// 비즈니스 로직 (todo 라는 기능으로 하나로 묶음)
class TodoUsecase {
  const TodoUsecase(this.repository); // 의존성 주입
  final TodoRepository repository;

  // todo 리스트 처음 불러오기
  Future<List<Todo>> getTodos() async {
    return repository.getTodos();
  }

  // todo 리스트 추가로 불러오기
  Future<List<Todo>> getMoreTodos(Todo lastTodo) async {
    return repository.getMoreTodos(lastTodo);
  }

  // todo 추가
  Future<void> addTodo(Todo todo) async {
    await repository.addTodo(todo);
  }

  // todo 수정
  Future<void> updateTodo(Todo todo) async {
    await repository.updateTodo(todo);
  }

  // todo 삭제
  Future<void> deleteTodo(String id) async {
    await repository.deleteTodo(id);
  }

  // 즐겨찾기 여부 변경
  Future<void> toggleFavorite(Todo todo) async {
    await repository.updateTodo(todo.copyWith(isFavorite: !todo.isFavorite));
  }

  // 완료 여부 변경
  Future<void> toggleDone(Todo todo) async {
    await repository.updateTodo(todo.copyWith(isDone: !todo.isDone));
  }
}
