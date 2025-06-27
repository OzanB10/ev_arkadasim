import 'package:ev_arkadasim/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Hive database initialization
  await Hive.initFlutter();
  
  // Dependency injection setup
  await initializeDependencies();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}




