import 'package:assignment4/view/home/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assignment4/model/to_do_model.dart';
import 'package:assignment4/view_model/to_do_view_model.dart';
import 'package:assignment4/core/app_theme.dart';
import 'package:assignment4/view/home/add_to_do_dialog.dart';
import 'package:assignment4/view/home/no_to_do.dart';
import 'package:assignment4/view/home/to_do_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ToDoViewModel 구독 (RiverPod 으로 전역 상태 관리)
    final List<ToDoModel> todos = ref.watch(toDoViewModelProvider);

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
          ? NoToDo(title: title) // 할 일 있을 때 화면
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) =>
                    ToDoView(todo: todos[index]), // 할 일 없을 때 화면
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
            builder: (context) => AddToDoDialog(),
          );
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add_rounded, size: 24),
      ),

      bottomNavigationBar: BottomAppBar(
        color: vrc(context).background200,
        height: 120,
        child: WeatherView(), // 현재 위치와 시간에 따른 날씨 정보 제공 화면
      ),
    );
  }
}
