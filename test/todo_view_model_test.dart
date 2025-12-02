import 'package:assignment4/data/data_source_impl/todo_data_source_impl.dart';
import 'package:assignment4/data/repository_impl/todo_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:assignment4/logic/entity/todo.dart';
import 'package:assignment4/logic/usecase/todo_usecase.dart';
import 'package:assignment4/ui/view_model/todo_view_model.dart';

// TodoViewModel : 메서드 + 상태관리 테스트
void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late TodoDataSourceImpl dataSource;
  late TodoRepositoryImpl repository;
  late TodoUsecase usecase;
  late TodoViewModel viewModel;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = TodoDataSourceImpl(fakeFirestore);
    repository = TodoRepositoryImpl(dataSource);
    usecase = TodoUsecase(repository);
    viewModel = TodoViewModel(usecase);
  });

  test('getTodos() : todo list 불러온 후 상태 없데이트 테스트', () async {
    final todo = Todo(
      id: '1',
      title: 'Test',
      description: 'desc',
      isDone: false,
      isFavorite: false,
      createdAt: DateTime.now(),
    );
    await fakeFirestore.collection('todos').doc(todo.id).set({
      'id': todo.id,
      'title': todo.title,
      'description': todo.description,
      'is_done': todo.isDone,
      'is_favorite': todo.isFavorite,
      'created_at': todo.createdAt.toIso8601String(),
    });

    await viewModel.getTodos();

    expect(viewModel.state.length, 1);
    expect(viewModel.state.first.title, 'Test');
  });

  test('addTodo() : 새로운 todo 추가 후 상태 업데이트 테스트', () async {
    final todo = Todo(
      id: '1',
      title: 'Test',
      description: 'desc',
      isDone: false,
      isFavorite: false,
      createdAt: DateTime.now(),
    );

    await viewModel.addTodo(todo);

    expect(viewModel.state.length, 1);
    expect(viewModel.state.first.id, '1');
    expect(viewModel.state.first.title, 'Test');
  });

  test('updateTodo() : todo 수정 후 상태 업데이트 테스트', () async {
    final todo = Todo(
      id: '1',
      title: 'Test',
      description: 'desc',
      isDone: false,
      isFavorite: false,
      createdAt: DateTime.now(),
    );

    await viewModel.addTodo(todo);

    final updatedTodo = todo.copyWith(title: 'Updated');
    await viewModel.updateTodo(updatedTodo);

    expect(viewModel.state.first.title, 'Updated');
  });

  test('deleteTodo() : todo 삭제 후 상태 업데이트 테스트', () async {
    final todo = Todo(
      id: '1',
      title: 'Test',
      description: 'desc',
      isDone: false,
      isFavorite: false,
      createdAt: DateTime.now(),
    );

    await viewModel.addTodo(todo);
    await viewModel.deleteTodo('1');

    expect(viewModel.state.isEmpty, true);
  });

  test('toggleFavorite() : 즐겨찾기 여부 변경 후 상태 업데이트 테스트', () async {
    final todo = Todo(
      id: '1',
      title: 'Test',
      description: 'desc',
      isDone: false,
      isFavorite: false,
      createdAt: DateTime.now(),
    );

    await viewModel.addTodo(todo);
    await viewModel.toggleFavorite(todo);

    expect(viewModel.state.first.isFavorite, true);
  });

  test('toggleDone() : 완료 여부 변경 후 상태 업데이트 테스트', () async {
    final todo = Todo(
      id: '1',
      title: 'Test',
      description: 'desc',
      isDone: false,
      isFavorite: false,
      createdAt: DateTime.now(),
    );

    await viewModel.addTodo(todo);
    await viewModel.toggleDone(todo);

    expect(viewModel.state.first.isDone, true);
  });
}
