import 'package:assignment4/model/to_do_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoRepository {
  // Firestore 객체 생성
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // R (전체 문서 읽기)
  Future<List<ToDoModel>> getToDos() async {
    final snapshot = await firestore.collection('todos').get();
    return snapshot.docs.map((doc) => ToDoModel.fromJson(doc.data())).toList();
  }

  // C
  Future<ToDoModel> addToDo(ToDoModel todo) async {
    final docRef = firestore.collection('todos').doc();
    // todo 생성 시 id = null 이므로, Firestore 에서 자동 생성된 문서 ID 값을 id 에 넣어줌
    final newToDo = todo.copyWith(id: docRef.id);
    await docRef.set(newToDo.toJson());
    return newToDo;
  }

  // U
  Future<void> updateToDo(ToDoModel todo) async {
    await firestore.collection('todos').doc(todo.id).update(todo.toJson());
  }

  // D
  Future<void> deleteToDo(ToDoModel todo) async {
    await firestore.collection('todos').doc(todo.id).delete();
  }
}
