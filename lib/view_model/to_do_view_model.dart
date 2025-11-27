import 'package:assignment4/model/to_do_model.dart';
import 'package:assignment4/repository/to_do_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_do_view_model.g.dart';

@riverpod
class ToDoViewModel extends _$ToDoViewModel {
  final ToDoRepository repository = ToDoRepository(); // 객체 생성

  @override
  List<ToDoModel> build() {
    getToDos();
    return [];
  }

  // R (Firestore 에서 데이터 가져오기)
  Future<void> getToDos() async {
    state = await repository.getToDos();
  }

  // C
  Future<void> addToDo(ToDoModel newToDo) async {
    final createdToDo = await repository.addToDo(newToDo);
    state = [...state, createdToDo];
  }

  // U
  Future<void> updateToDo(ToDoModel updated) async {
    await repository.updateToDo(updated);
    state = state
        .map((todo) => todo.id == updated.id ? updated : todo)
        .toList();
  }

  // D
  Future<void> deleteToDo(String id) async {
    final todo = state.firstWhere((t) => t.id == id);
    await repository.deleteToDo(todo);
    state = state.where((t) => t.id != id).toList();
  }

  // Favorite
  Future<void> toggleFavorite(String id) async {
    final todo = state.firstWhere((t) => t.id == id);
    await updateToDo(todo.copyWith(isFavorite: !todo.isFavorite));
  }

  // Done
  Future<void> toggleDone(String id) async {
    final todo = state.firstWhere((t) => t.id == id);
    await updateToDo(todo.copyWith(isDone: !todo.isDone));
  }
}
