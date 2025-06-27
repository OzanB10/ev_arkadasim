import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'themes/app_theme.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/api_test_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/house/presentation/screens/house_create_screen.dart';
import '../features/house/presentation/screens/house_join_screen.dart';
import '../features/house/presentation/screens/house_settings_screen.dart';
import '../features/expenses/presentation/screens/expense_add_screen.dart';
import '../features/expenses/presentation/screens/expense_list_screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'EvArkadaşım',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/api-test': (context) => const ApiTestScreen(),
        '/home': (context) => const HomeScreen(),
        '/house/create': (context) => const HouseCreateScreen(),
        '/house/join': (context) => const HouseJoinScreen(),
        '/house/settings': (context) => const HouseSettingsScreen(),
        '/expenses': (context) => const ExpenseListScreen(),
        '/expenses/add': (context) => const ExpenseAddScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
} 