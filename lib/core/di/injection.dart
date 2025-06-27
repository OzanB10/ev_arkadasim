import 'package:get_it/get_it.dart';

import '../services/database_service.dart';
import '../../features/house/data/repositories/house_repository_impl.dart';
import '../../features/house/domain/repositories/house_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Database
  await DatabaseService.initialize();
  
  // Repositories
  sl.registerLazySingleton<HouseRepository>(
    () => HouseRepositoryImpl(),
  );
  
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );
} 