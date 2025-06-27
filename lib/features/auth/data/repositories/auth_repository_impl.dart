import 'dart:convert';
import 'package:hive/hive.dart';

import '../../../../core/services/api_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'current_user';
  static const String _boxName = 'auth_box';

  late Box _authBox;

  Future<void> _initBox() async {
    _authBox = await Hive.openBox(_boxName);
  }

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    await _initBox();

    final response = await ApiService.post<Map<String, dynamic>>(
      'login',
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.isSuccess && response.data != null) {
      // Laravel'in direkt döndürdüğü format için
      final responseData = response.data!;
      
      final authResponse = AuthResponse(
        user: User(
          id: responseData['user']['id'],
          name: responseData['user']['name'],
          email: responseData['user']['email'],
          emailVerifiedAt: responseData['user']['email_verified_at'],
          createdAt: responseData['user']['created_at'] ?? DateTime.now().toIso8601String(),
          updatedAt: responseData['user']['updated_at'] ?? DateTime.now().toIso8601String(),
        ),
        token: responseData['token'],
        tokenType: 'Bearer',
      );
      
      // Token'ı kaydet
      await saveToken(authResponse.token);
      
      // Kullanıcı bilgilerini kaydet
      await _authBox.put(_userKey, json.encode(authResponse.user.toJson()));
      
      return authResponse;
    } else {
      throw Exception(response.error?.message ?? 'Giriş başarısız');
    }
  }

  @override
  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    await _initBox();

    final response = await ApiService.post<Map<String, dynamic>>(
      'register',
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    if (response.isSuccess && response.data != null) {
      // Laravel'in direkt döndürdüğü format için
      final responseData = response.data!;
      
      final authResponse = AuthResponse(
        user: User(
          id: responseData['user']['id'],
          name: responseData['user']['name'],
          email: responseData['user']['email'],
          emailVerifiedAt: responseData['user']['email_verified_at'],
          createdAt: responseData['user']['created_at'] ?? DateTime.now().toIso8601String(),
          updatedAt: responseData['user']['updated_at'] ?? DateTime.now().toIso8601String(),
        ),
        token: responseData['token'],
        tokenType: 'Bearer',
      );
      
      // Token'ı kaydet
      await saveToken(authResponse.token);
      
      // Kullanıcı bilgilerini kaydet
      await _authBox.put(_userKey, json.encode(authResponse.user.toJson()));
      
      return authResponse;
    } else {
      throw Exception(response.error?.message ?? 'Kayıt başarısız');
    }
  }

  @override
  Future<void> logout() async {
    await _initBox();
    
    final token = await getToken();
    if (token != null) {
      try {
        await ApiService.post<Map<String, dynamic>>(
          'logout',
          token: token,
        );
      } catch (e) {
        // API çağrısı başarısız olsa bile yerel verileri temizle
        print('Logout API error: $e');
      }
    }
    
    await removeToken();
    await _authBox.delete(_userKey);
  }

  @override
  Future<User?> getCurrentUser() async {
    await _initBox();
    
    final userJson = _authBox.get(_userKey);
    if (userJson != null) {
      try {
        final userMap = json.decode(userJson);
        return User.fromJson(userMap);
      } catch (e) {
        print('User parsing error: $e');
        return null;
      }
    }
    return null;
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    final user = await getCurrentUser();
    return token != null && user != null;
  }

  @override
  Future<String?> getToken() async {
    await _initBox();
    return _authBox.get(_tokenKey);
  }

  @override
  Future<void> saveToken(String token) async {
    await _initBox();
    await _authBox.put(_tokenKey, token);
  }

  @override
  Future<void> removeToken() async {
    await _initBox();
    await _authBox.delete(_tokenKey);
  }
} 