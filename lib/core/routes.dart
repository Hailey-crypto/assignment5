import 'package:assignment4/ui/view/error/error_page.dart';
import 'package:assignment4/ui/view/home/home_page.dart';
import 'package:assignment4/ui/view/todo_detail/todo_detail_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    // / = HomePage
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        // /detail/:id = TodoDetailPage (pathParameter 로 id 전달)
        GoRoute(
          path: 'detail/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return TodoDetailPage(id: id);
          },
        ),
      ],
    ),
  ],
  // 최초 위치 = HomePage
  initialLocation: '/',
  // 잘못된 경로 입력 시 = ErrorPage
  errorBuilder: (context, state) {
    return const ErrorPage();
  },
);
