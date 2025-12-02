import 'package:assignment4/logic/entity/todo.dart';
import 'package:assignment4/ui/provider/todo_provider.dart';
import 'package:assignment4/ui/view/home/add_todo_dialog.dart';
import 'package:assignment4/ui/view/home/no_todo.dart';
import 'package:assignment4/ui/view/home/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assignment4/core/app_theme.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  final String title = '혜린`s Tasks';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TodoViewModel 구독
    final List<Todo> todos = ref.watch(todoViewModelProvider);

    return Scaffold(
      backgroundColor: vrc(context).background300,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: vrc(context).background200,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: vrc(context).textColor200,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // 무한 스크롤
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent) {
              ref.read(todoViewModelProvider.notifier).getMoreTodos();
            }
            return true; // 조건 충족 시 이벤트 처리
          }
          return false;
        },
        // 당겨서 새로고침
        child: RefreshIndicator(
          color: fxc(context).brandColor,
          backgroundColor: vrc(context).background200,
          onRefresh: () => ref.read(todoViewModelProvider.notifier).getTodos(),
          child: todos.isEmpty
              ? NoTodo(title: title) // 할 일 있을 때 화면
              : Container(
                  padding: const EdgeInsets.all(12),
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 16),
                    itemCount: todos.length,
                    itemBuilder: (context, index) =>
                        TodoView(todo: todos[index]), // 할 일 없을 때 화면
                  ),
                ),
        ),
      ),
      // 할 일 추가 버튼
      floatingActionButton: TapDebouncer(
        onTap: () async => await showModalBottomSheet(
          backgroundColor: vrc(context).background100,
          isScrollControlled: true,
          context: context,
          builder: (context) => AddTodoDialog(),
        ),
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return FloatingActionButton(
            foregroundColor: Colors.white,
            backgroundColor: fxc(context).brandColor,
            shape: CircleBorder(),
            onPressed: onTap,
            child: const Icon(Icons.add_rounded, size: 24),
          );
        },
      ),
    );
  }
}
