import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Auth state
class AuthState {
  final User? user;
  final bool isLoggedIn;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    required this.isLoggedIn,
    required this.isLoading,
    this.error,
  });

  AuthState copyWith({
    User? user,
    bool? isLoggedIn,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

/// Auth controller
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthController(this._authRepository)
      : super(const AuthState(isLoggedIn: false, isLoading: false)) {
    _checkAuthStatus();
  }

  /// Başlangıçta auth durumunu kontrol et
  Future<void> _checkAuthStatus() async {
    state = state.copyWith(isLoading: true);
    try {
      final isLoggedIn = await _authRepository.isLoggedIn();
      if (isLoggedIn) {
        final user = await _authRepository.getCurrentUser();
        state = state.copyWith(
          user: user,
          isLoggedIn: true,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoggedIn: false,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Auth kontrolü başarısız: $e',
      );
    }
  }

  /// Login işlemi
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final authResponse = await _authRepository.login(
        email: email,
        password: password,
      );
      
      state = state.copyWith(
        user: authResponse.user,
        isLoggedIn: true,
        isLoading: false,
      );
      
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  /// Register işlemi
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final authResponse = await _authRepository.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      
      state = state.copyWith(
        user: authResponse.user,
        isLoggedIn: true,
        isLoading: false,
      );
      
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  /// Logout işlemi
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await _authRepository.logout();
      state = const AuthState(isLoggedIn: false, isLoading: false);
    } catch (e) {
      // Logout hatası olsa bile state'i temizle
      state = state.copyWith(
        isLoading: false,
        error: 'Çıkış işlemi tamamlanamadı: $e',
      );
    }
  }

  /// Error'u temizle
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Auth durumunu yenile
  Future<void> refresh() async {
    await _checkAuthStatus();
  }
}

/// Auth controller provider
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref.read(authRepositoryProvider));
}); 