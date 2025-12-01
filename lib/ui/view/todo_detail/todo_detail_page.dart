import 'package:assignment4/ui/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:assignment4/core/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

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
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Hero(
          tag: '${todo.id}',
          child: Material(
            color: Colors.transparent,
            // 제목
            child: Text(
              todo.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: vrc(context).textColor200,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          // 즐겨찾기 버튼
          TapDebouncer(
            onTap: () async => await ref
                .read(todoViewModelProvider.notifier)
                .toggleFavorite(todo),
            builder: (BuildContext context, TapDebouncerFunc? onTap) {
              return InkWell(
                onTap: onTap,
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Icon(
                      todo.isFavorite
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      size: 30,
                      color: vrc(context).textColor200,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          // 반응형 UI (모바일 가로/세로 모드에 따라 여백 변경)
          horizontal: MediaQuery.of(context).size.width >= 480 ? 50 : 20,
        ),
        child: Row(
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
                todo.description ?? '세부정보',
                style: TextStyle(
                  color: vrc(context).textColor200,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
