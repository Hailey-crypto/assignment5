import 'package:assignment4/model/to_do_model.dart';
import 'package:assignment4/view_model/to_do_view_model.dart';
import 'package:flutter/material.dart';
import 'package:assignment4/core/app_theme.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddToDoDialog extends HookConsumerWidget {
  const AddToDoDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // (Flutter Hooks 로 지역 상태 관리)
    final isFavorite = useState(false);
    final isDescriptionActivated = useState(false);
    final filled = useState(false);

    // 사용자 입력값 받기
    final titController = useTextEditingController();
    final desController = useTextEditingController();

    // 제목 입력값 변화 감지해서 상태 변경
    useEffect(() {
      titController.addListener(() {
        filled.value = titController.text.trim().isNotEmpty;
      });
      return;
    }, [titController]);

    // 저장 함수
    void saveToDo() {
      final title = titController.text.trim();
      final description = desController.text.trim().isEmpty
          ? null
          : desController.text.trim();
      // 제목 입력값 있을 때
      if (title.isNotEmpty) {
        ref
            .read(toDoViewModelProvider.notifier)
            .addToDo(
              ToDoModel(
                title: title,
                description: description,
                isFavorite: isFavorite.value,
                isDone: false,
              ),
            );
        Navigator.of(context).pop();
        return;
        // 제목 입력값 없을 때
      } else {
        Navigator.of(context).pop();
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

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          // 제목 입력창
          TextField(
            controller: titController,
            autofocus: true,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: fxc(context).brandColor!,
                  width: 2,
                ),
              ),
              hintStyle: TextStyle(fontSize: 16),
              hintText: '새 할 일',
            ),
            onSubmitted: (value) => saveToDo(), // 저장 함수 실행
          ),
          // 세부정보 입력창
          if (isDescriptionActivated.value)
            TextField(
              controller: desController,
              style: TextStyle(fontSize: 14),
              maxLines: 5,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: fxc(context).brandColor!,
                    width: 2,
                  ),
                ),
                hintText: '세부정보 추가',
              ),
            ),
          // 하단 버튼
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    // 세부정보 버튼
                    if (!isDescriptionActivated.value)
                      InkWell(
                        onTap: () => isDescriptionActivated.value = true,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: Icon(Icons.short_text_rounded, size: 24),
                          ),
                        ),
                      ),
                    // 즐겨찾기 버튼
                    InkWell(
                      onTap: () => isFavorite.value = !isFavorite.value,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Icon(
                            isFavorite.value
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // 저장 버튼
                InkWell(
                  onTap: () => saveToDo(), // 저장 함수 실행
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      '저장',
                      style: TextStyle(
                        color: filled.value
                            ? fxc(context).brandColor
                            : vrc(context).textColor100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
