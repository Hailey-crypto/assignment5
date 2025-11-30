import 'package:assignment4/logic/entity/todo.dart';
import 'package:assignment4/ui/provider/todo_provider.dart';
import 'package:assignment4/ui/view/home/add_todo_dialog.dart';
import 'package:assignment4/ui/view/home/no_todo.dart';
import 'package:assignment4/ui/view/home/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assignment4/core/app_theme.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  final String title = '혜린`s Tasks';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TodoViewModel 구독 (RiverPod 으로 전역 상태 관리)
    final List<Todo> todos = ref.watch(todoViewModelProvider);

    return Scaffold(
      backgroundColor: vrc(context).background300,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: vrc(context).background200,
        scrolledUnderElevation: 0,
        title: Text(
          title,
          style: TextStyle(
            color: vrc(context).textColor200,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: todos.isEmpty
          ? NoTodo(title: title) // 할 일 있을 때 화면
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) =>
                    TodoView(todo: todos[index]), // 할 일 없을 때 화면
              ),
            ),
      // 할 일 추가 버튼
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: fxc(context).brandColor,
        shape: CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: vrc(context).background100,
            isScrollControlled: true,
            context: context,
            builder: (context) => AddTodoDialog(),
          );
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add_rounded, size: 24),
      ),
    );
  }
}
