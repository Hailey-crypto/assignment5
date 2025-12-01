import 'package:assignment4/data/data_source/todo_data_source.dart';
import 'package:assignment4/data/dto/todo_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Firestore 데이터 변환
class TodoDataSourceImpl implements TodoDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override // R (처음 불러오기)
  Future<List<TodoDto>> getTodos() async {
    final snapshot = await firestore
        .collection('todos')
        .orderBy('created_at', descending: true) // createdAt 내림차순으로 정렬
        .limit(15) // 15개만 보여줌
        .get();
    return snapshot.docs.map((doc) => TodoDto.fromJson(doc.data())).toList();
  }

  @override // R (추가로 불러오기)
  Future<List<TodoDto>> getMoreTodos(TodoDto lastTodo) async {
    final snapshot = await firestore
        .collection('todos')
        .orderBy('created_at', descending: true)
        .startAfter([lastTodo.createdAt.toIso8601String()])
        .limit(15)
        .get();
    return snapshot.docs.map((doc) => TodoDto.fromJson(doc.data())).toList();
  }

  @override // C
  Future<void> addTodo(TodoDto todo) async {
    final docRef = firestore.collection('todos').doc();
    final newDto = todo.copyWith(id: docRef.id); // id 에 문서 ID 넣기
    await docRef.set(newDto.toJson());
  }

  @override // U
  Future<void> updateTodo(TodoDto todo) async {
    await firestore.collection('todos').doc(todo.id).update(todo.toJson());
  }

  @override // D
  Future<void> deleteTodo(String id) async {
    await firestore.collection('todos').doc(id).delete();
  }
}
