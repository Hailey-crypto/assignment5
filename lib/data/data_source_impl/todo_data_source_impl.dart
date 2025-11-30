import 'package:assignment4/data/data_source/todo_data_source.dart';
import 'package:assignment4/data/dto/todo_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Firestore 데이터 변환
class TodoDataSourceImpl implements TodoDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override // R
  Future<List<TodoDto>> getTodos() async {
    final snapshot = await firestore.collection('todos').get();
    return snapshot.docs.map((doc) {
      final dto = TodoDto.fromJson(doc.data());
      return dto.copyWith(id: doc.id); // id 에 문서ID 넣기
    }).toList();
  }

  @override // C
  Future<void> addTodo(TodoDto todo) async {
    final docRef = firestore.collection('todos').doc();
    final newDto = todo.copyWith(id: docRef.id); // id 에 문서ID 넣기
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
