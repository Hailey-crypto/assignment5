import 'package:assignment4/logic/entity/todo.dart';
import 'package:assignment4/ui/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:assignment4/core/app_theme.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class TodoDetailPage extends HookConsumerWidget {
  const TodoDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TodoViewModel 구독
    final todo = ref.watch(todoViewModelProvider).firstWhere((t) => t.id == id);

    // Flutter Hooks 로 지역 상태 관리
    final isEditing = useState(false);

    // 사용자 입력값 받기
    final titController = useTextEditingController();
    final desController = useTextEditingController();

    // 기존 입력값 불러오기
    useEffect(() {
      titController.text = todo.title;
      desController.text = todo.description ?? '';
      return;
    }, [titController, desController]);

    // 수정 함수
    void editToDo() {
      final title = titController.text.trim();
      // 제목 입력값 있을 때
      if (title.isNotEmpty) {
        ref
            .read(todoViewModelProvider.notifier)
            .updateTodo(
              Todo(
                id: todo.id,
                title: titController.text,
                description: desController.text,
                isFavorite: todo.isFavorite,
                isDone: todo.isDone,
                createdAt: todo.createdAt,
              ),
            );
        isEditing.value = false;
        return;
        // 제목 입력값 없을 때
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '할 일을 입력해주세요.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: fxc(context).brandColor,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: vrc(context).background300,
      appBar: AppBar(
        backgroundColor: vrc(context).background200,
        scrolledUnderElevation: 0,
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 5),
        title: Hero(
          tag: '${todo.id}',
          child: Material(
            color: Colors.transparent,
            // 제목
            child: isEditing.value
                ? TextField(
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    controller: titController,
                    style: TextStyle(fontSize: 20),
                    autofocus: true,
                    cursorColor: fxc(context).brandColor,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: fxc(context).brandColor!,
                          width: 2,
                        ),
                      ),
                    ),
                    onSubmitted: (value) => editToDo(), // 수정 함수 실행
                  )
                : Text(
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
          // 수정 버튼
          TapDebouncer(
            onTap: () async {
              if (isEditing.value) {
                editToDo();
                isEditing.value = !isEditing.value;
              }
              isEditing.value = !isEditing.value;
            },

            builder: (BuildContext context, TapDebouncerFunc? onTap) {
              return IconButton(
                onPressed: onTap,
                icon: Icon(isEditing.value ? Icons.done : Icons.edit),
              );
            },
          ),

          // 즐겨찾기 버튼
          TapDebouncer(
            onTap: () async => await ref
                .read(todoViewModelProvider.notifier)
                .toggleFavorite(todo),
            builder: (BuildContext context, TapDebouncerFunc? onTap) {
              return IconButton(
                onPressed: onTap,
                icon: Icon(
                  todo.isFavorite
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
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
              child: isEditing.value
                  ? TextField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      controller: desController,
                      style: TextStyle(fontSize: 16),
                      maxLines: 50,
                      cursorColor: fxc(context).brandColor,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: fxc(context).brandColor!,
                            width: 2,
                          ),
                        ),
                      ),
                    )
                  : Text(
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
