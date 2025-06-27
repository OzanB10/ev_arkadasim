import '../entities/user.dart';

abstract class AuthRepository {
  Future<AuthResponse> login({
    required String email,
    required String password,
  });

  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<void> logout();

  Future<User?> getCurrentUser();

  Future<bool> isLoggedIn();

  Future<String?> getToken();

  Future<void> saveToken(String token);

  Future<void> removeToken();
} 