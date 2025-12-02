import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:assignment4/data/data_source_impl/todo_data_source_impl.dart';
import 'package:assignment4/data/dto/todo_dto.dart';

// TodoDataSourceImpl : 메서드 + Firestore CRUD 테스트
void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late TodoDataSourceImpl dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = TodoDataSourceImpl(fakeFirestore);
  });

  test('getTodos() : todo list 불러오기 + createdAt 최신순 정렬 테스트', () async {
    await fakeFirestore.collection('todos').add({
      'id': '1',
      'title': 'title1',
      'description': 'description1',
      'is_favorite': false,
      'is_done': false,
      'created_at': '2025-01-01T00:00:00.000000',
    });
    await fakeFirestore.collection('todos').add({
      'id': '2',
      'title': 'title2',
      'description': 'description2',
      'is_favorite': false,
      'is_done': false,
      'created_at': '2025-01-02T00:00:00.000000',
    });

    final todos = await dataSource.getTodos();

    expect(todos.length, 2);
    expect(todos.first.id, '2');
  });

  test('addTodo() : 새로운 todo 추가 테스트', () async {
    final todo = TodoDto(
      id: null, // addTodo() 내부에서 Firestore 문서 ID로 대체됨
      title: 'title1',
      description: 'description1',
      isFavorite: false,
      isDone: false,
      createdAt: DateTime.parse('2025-01-01T12:00:00.000000'),
    );

    await dataSource.addTodo(todo);

    final snapshot = await fakeFirestore.collection('todos').get();
    expect(snapshot.docs.length, 1);
    expect(snapshot.docs.first.data()['title'], 'title1');
  });

  test('updateTodo() : 문서 업데이트 테스트', () async {
    await fakeFirestore.collection('todos').doc('1').set({
      'id': '1',
      'title': 'title_old',
      'description': 'description_old',
      'is_favorite': false,
      'is_done': false,
      'created_at': '2025-01-01T00:00:00.000000',
    });

    final updated = TodoDto(
      id: '1',
      title: 'title_new',
      description: 'description_new',
      isFavorite: false,
      isDone: true,
      createdAt: DateTime.parse('2025-01-01T00:00:00.000000'),
    );

    await dataSource.updateTodo(updated);

    final snapshot = await fakeFirestore.collection('todos').doc('1').get();
    final data = snapshot.data()!;

    expect(data['title'], 'title_new');
    expect(data['is_done'], true);
  });

  test('deleteTodo() : 문서 삭제 테스트', () async {
    await fakeFirestore.collection('todos').doc('deleteid').set({
      'id': '1',
      'title': 'title1',
      'description': 'description1',
      'is_favorite': false,
      'is_done': false,
      'created_at': '2025-01-01T00:00:00.000000',
    });

    await dataSource.deleteTodo('1');
    final exists =
        (await fakeFirestore.collection('todos').doc('1').get()).exists;

    expect(exists, false);
  });
}
