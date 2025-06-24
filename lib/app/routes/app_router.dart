import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/house/presentation/screens/house_create_screen.dart';
import '../../features/house/presentation/screens/house_join_screen.dart';
import '../../features/expenses/presentation/screens/expense_add_screen.dart';
import '../../features/expenses/presentation/screens/expense_list_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    // Home route
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      initial: true,
    ),
    
    // House routes
    AutoRoute(
      page: HouseCreateRoute.page,
      path: '/house/create',
    ),
    AutoRoute(
      page: HouseJoinRoute.page,
      path: '/house/join',
    ),
    
    // Expense routes
    AutoRoute(
      page: ExpenseListRoute.page,
      path: '/expenses',
    ),
    AutoRoute(
      page: ExpenseAddRoute.page,
      path: '/expenses/add',
    ),
  ];
}

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
}); 