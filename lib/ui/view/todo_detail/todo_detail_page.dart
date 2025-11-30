import 'package:assignment4/ui/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:assignment4/core/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoDetailPage extends ConsumerWidget {
  const TodoDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TodoViewModel 구독 (RiverPod 으로 전역 상태 관리)
    final todo = ref.watch(todoViewModelProvider).firstWhere((t) => t.id == id);

    return Scaffold(
      backgroundColor: vrc(context).background300,
      appBar: AppBar(
        backgroundColor: vrc(context).background200,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          // 즐겨찾기 버튼
          InkWell(
            onTap: () {
              ref.read(todoViewModelProvider.notifier).toggleFavorite(todo);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              width: 48,
              height: 48,
              child: Center(
                child: Icon(
                  todo.isFavorite
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  size: 24,
                  color: vrc(context).textColor200,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: vrc(context).background300,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            // 제목
            Text(
              todo.title,
              style: TextStyle(
                color: vrc(context).textColor200,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Icon(
                  Icons.short_text_rounded,
                  size: 24,
                  color: vrc(context).textColor200,
                ),
                // 세부정보
                Expanded(
                  child: Text(
                    todo.description ?? '세부정보 추가',
                    style: TextStyle(
                      color: vrc(context).textColor200,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
