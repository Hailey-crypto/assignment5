import 'package:assignment4/logic/entity/todo.dart';
import 'package:assignment4/logic/usecase/todo_usecase.dart';
import 'package:flutter_riverpod/legacy.dart';

// 상태관리
class TodoViewModel extends StateNotifier<List<Todo>> {
  final TodoUsecase usecase;

  // 페이지네이션 상태
  bool isLoadingMore = false; // 페이지 로딩 중 여부
  bool hasMore = true; // 더 불러올 페이지 있는지 여부

  // 상태(state) 초기값 = [], ViewModel 생성되면 바로 Todo 데이터를 가져옴
  TodoViewModel(this.usecase) : super([]) {
    getTodos();
  }

  // todo 리스트 처음 불러오기
  Future<void> getTodos() async {
    try {
      final result = await usecase.getTodos();
      state = result;
      hasMore = result.length == 15; // 더 불러올 페이지 있는지 확인
    } catch (e) {
      state = [];
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
    }
  }

  // todo 추가
  Future<void> addTodo(Todo todo) async {
    await usecase.addTodo(todo);
    await getTodos();
  }

  // todo 수정
  Future<void> updateTodo(Todo todo) async {
    await usecase.updateTodo(todo);
    await getTodos();
  }

  // todo 삭제
  Future<void> deleteTodo(String id) async {
    await usecase.deleteTodo(id);
    await getTodos();
  }

  // 즐겨찾기 여부 변경
  Future<void> toggleFavorite(Todo todo) async {
    await usecase.toggleFavorite(todo);
    await getTodos();
  }

  // 완료 여부 변경
  Future<void> toggleDone(Todo todo) async {
    await usecase.toggleDone(todo);
    await getTodos();
  }
}
