import 'package:gestion_t/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add_task',
      builder: (context, state) => const TaskScreen(),
    ),
  ]
);