import 'package:assignment4/model/to_do_model.dart';
import 'package:assignment4/view_model/to_do_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assignment4/core/app_theme.dart';
import 'package:assignment4/view/to_do_detail/to_do_detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToDoView extends ConsumerWidget {
  const ToDoView({super.key, required this.todo});
  final ToDoModel todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: vrc(context).background200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 12,
        children: [
          // 완료 버튼
          InkWell(
            onTap: () =>
                ref.read(toDoViewModelProvider.notifier).toggleDone(todo.id!),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: Icon(
                  todo.isDone
                      ? Icons.check_circle_rounded
                      : Icons.circle_outlined,
                ),
              ),
            ),
          ),
          // 할 일 누르면 세부정보 페이지로 이동
          Expanded(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ToDoDetailPage(id: todo.id!),
                ),
              ),
              child: Text(
                todo.title,
                style: TextStyle(
                  color: vrc(context).textColor200,
                  fontSize: 16,
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ),
          // 즐겨찾기 버튼
          InkWell(
            onTap: () => ref
                .read(toDoViewModelProvider.notifier)
                .toggleFavorite(todo.id!),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: Icon(
                  todo.isFavorite
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                ),
              ),
            ),
          ),
          // 삭제 버튼
          InkWell(
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(todo.title),
                    content: Text('삭제 하시겠습니까?'),
                    actions: [
                      CupertinoDialogAction(
                        textStyle: TextStyle(color: fxc(context).brandColor),
                        isDefaultAction: false,
                        onPressed: () => Navigator.pop(context),
                        child: Text('취소'),
                      ),
                      CupertinoDialogAction(
                        textStyle: TextStyle(color: fxc(context).brandColor),
                        isDefaultAction: true,
                        onPressed: () {
                          ref
                              .read(toDoViewModelProvider.notifier)
                              .deleteToDo(todo.id!);
                          Navigator.pop(context);
                        },
                        child: Text('확인'),
                      ),
                    ],
                  );
                },
              );
            },
            child: SizedBox(
              width: 40,
              height: 40,
              child: Center(child: Icon(Icons.delete)),
            ),
          ),
        ],
      ),
    );
  }
}
