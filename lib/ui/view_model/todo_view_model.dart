import 'package:assignment4/logic/entity/todo.dart';
import 'package:assignment4/logic/usecase/todo_usecase.dart';
import 'package:flutter_riverpod/legacy.dart';

// 상태관리
class TodoViewModel extends StateNotifier<List<Todo>> {
  final TodoUsecase usecase;

  TodoViewModel(this.usecase)
    // 상태(state) 초기값
    : super([]) {
    // ViewModel 생성되면 바로 Todo 데이터를 가져오도록 getTodos() 호출
    getTodos();
  }

  Future<void> getTodos() async {
    try {
      final result = await usecase.getTodos();
      state = result;
    } catch (e) {
      // 에러 발생 시 예외처리
      state = [];
    }
  }

  Future<void> addTodo(Todo todo) async {
    await usecase.addTodo(todo);
    await getTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await usecase.updateTodo(todo);
    await getTodos();
  }

  Future<void> deleteTodo(String id) async {
    await usecase.deleteTodo(id);
    await getTodos();
  }

  Future<void> toggleFavorite(Todo todo) async {
    await usecase.toggleFavorite(todo);
    await getTodos();
  }

  Future<void> toggleDone(Todo todo) async {
    await usecase.toggleDone(todo);
    await getTodos();
  }
}
