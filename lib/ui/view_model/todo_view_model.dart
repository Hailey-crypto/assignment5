import 'package:assignment4/logic/entity/todo.dart';
import 'package:assignment4/logic/usecase/todo_usecase.dart';
import 'package:flutter_riverpod/legacy.dart';

// 상태관리
class TodoViewModel extends StateNotifier<List<Todo>> {
  TodoViewModel(this.usecase) // 의존성 주입
    : super([]) {
    getTodos();
  }
  final TodoUsecase usecase;

  // 페이지네이션 상태
  bool isLoadingMore = false; // 페이지 로딩 중 여부
  bool hasMore = true; // 더 불러올 페이지 있는지 여부

  // todo 리스트 처음 불러오기
  Future<void> getTodos() async {
    try {
      final result = await usecase.getTodos();
      state = result;
      hasMore = result.length == 15; // 더 불러올 페이지 있는지 확인
    } catch (e) {
      state = [];
      print(e);
    }
  }

  // todo 리스트 추가로 불러오기
  Future<void> getMoreTodos() async {
    try {
      // 이미 로딩 중이면, 더 이상 불러올 게 없으면 > 실행 X
      if (isLoadingMore || !hasMore) return;

      isLoadingMore = true;

      final lastTodo = state.last; // 현재 리스트 마지막 항목을 기준으로 다음 페이지를 요청
      final result = await usecase.getMoreTodos(lastTodo);

      if (result.isEmpty) {
        hasMore = false;
      } else {
        await Future.delayed(Duration(seconds: 1));
        state = [...state, ...result];
      }

      isLoadingMore = false;
    } catch (e) {
      isLoadingMore = false;
      print(e);
    }
  }

  // todo 추가
  Future<void> addTodo(Todo todo) async {
    state = [todo, ...state];
    try {
      await usecase.addTodo(todo);
    } catch (e) {
      print(e);
    }
  }

  // todo 수정
  Future<void> updateTodo(Todo todo) async {
    state = state.map((t) => t.id == todo.id ? todo : t).toList();
    try {
      await usecase.updateTodo(todo);
    } catch (e) {
      print(e);
    }
  }

  // todo 삭제
  Future<void> deleteTodo(String id) async {
    state = state.where((t) => t.id != id).toList();
    try {
      await usecase.deleteTodo(id);
    } catch (e) {
      print(e);
    }
  }

  // 즐겨찾기 여부 변경
  Future<void> toggleFavorite(Todo todo) async {
    final updated = todo.copyWith(isFavorite: !todo.isFavorite);
    state = state.map((t) => t.id == todo.id ? updated : t).toList();
    try {
      await usecase.toggleFavorite(updated);
    } catch (e) {
      print(e);
    }
  }

  // 완료 여부 변경
  Future<void> toggleDone(Todo todo) async {
    final updated = todo.copyWith(isDone: !todo.isDone);
    state = state.map((t) => t.id == todo.id ? updated : t).toList();
    try {
      await usecase.toggleDone(updated);
    } catch (e) {
      print(e);
    }
  }
}
