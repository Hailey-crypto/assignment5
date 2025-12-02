import 'package:assignment4/data/data_source/todo_data_source.dart';
import 'package:assignment4/data/data_source_impl/todo_data_source_impl.dart';
import 'package:assignment4/data/repository_impl/todo_repository_impl.dart';
import 'package:assignment4/logic/entity/todo.dart';
import 'package:assignment4/logic/repository/todo_repository.dart';
import 'package:assignment4/logic/usecase/todo_usecase.dart';
import 'package:assignment4/ui/view_model/todo_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// provider 로 의존성 및 상태 전역적으로 관리
final firestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final todoDataSourceProvider = Provider<TodoDataSource>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return TodoDataSourceImpl(firestore);
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final dataSource = ref.watch(todoDataSourceProvider);
  return TodoRepositoryImpl(dataSource);
});

final todoUsecaseProvider = Provider<TodoUsecase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return TodoUsecase(repository);
});

final todoViewModelProvider = StateNotifierProvider<TodoViewModel, List<Todo>>((
  ref,
) {
  final usecase = ref.watch(todoUsecaseProvider);
  return TodoViewModel(usecase);
});
