import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// API istekleri için merkezi servis sınıfı
class ApiService {
  // Android emulator için 10.0.2.2, web/iOS simulator için 127.0.0.1
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const Duration timeoutDuration = Duration(seconds: 30);

  /// HTTP headers
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Authentication token eklemek için headers
  static Map<String, String> _headersWithAuth(String? token) {
    final headers = Map<String, String>.from(_headers);
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  /// GET request
  static Future<ApiResponse<T>> get<T>(
    String endpoint, {
    String? token,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpoint');
      final uriWithQuery = queryParameters != null
          ? uri.replace(queryParameters: queryParameters)
          : uri;

      final response = await http
          .get(
            uriWithQuery,
            headers: _headersWithAuth(token),
          )
          .timeout(timeoutDuration);

      return _handleResponse<T>(response);
    } catch (e) {
      return ApiResponse.error(_handleException(e));
    }
  }

  /// POST request
  static Future<ApiResponse<T>> post<T>(
    String endpoint, {
    String? token,
    Map<String, dynamic>? body,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpoint');

      final response = await http
          .post(
            uri,
            headers: _headersWithAuth(token),
            body: body != null ? json.encode(body) : null,
          )
          .timeout(timeoutDuration);

      return _handleResponse<T>(response);
    } catch (e) {
      return ApiResponse.error(_handleException(e));
    }
  }

  /// PUT request
  static Future<ApiResponse<T>> put<T>(
    String endpoint, {
    String? token,
    Map<String, dynamic>? body,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpoint');

      final response = await http
          .put(
            uri,
            headers: _headersWithAuth(token),
            body: body != null ? json.encode(body) : null,
          )
          .timeout(timeoutDuration);

      return _handleResponse<T>(response);
    } catch (e) {
      return ApiResponse.error(_handleException(e));
    }
  }

  /// DELETE request
  static Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpoint');

      final response = await http
          .delete(
            uri,
            headers: _headersWithAuth(token),
          )
          .timeout(timeoutDuration);

      return _handleResponse<T>(response);
    } catch (e) {
      return ApiResponse.error(_handleException(e));
    }
  }

  /// Response işleme
  static ApiResponse<T> _handleResponse<T>(http.Response response) {
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');
    
    try {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.success(
          data: responseData as T?, // Type cast ekle
          message: responseData['message'] ?? 'Success',
        );
      } else {
        return ApiResponse.error(ApiError(
          message: responseData['message'] ?? 'Unknown error',
          statusCode: response.statusCode,
          errors: responseData['errors'],
        ));
      }
    } catch (e) {
      print('JSON Parse Error: $e');
      return ApiResponse.error(ApiError(
        message: 'Response parsing error: $e',
        statusCode: response.statusCode,
      ));
    }
  }

  /// Exception işleme
  static ApiError _handleException(dynamic exception) {
    print('API Exception: $exception'); // Debug için
    
    if (exception is SocketException) {
      return ApiError(
        message: 'İnternet bağlantısı bulunamadı. Server çalışıyor mu?',
        statusCode: 0,
      );
    } else if (exception is HttpException) {
      return ApiError(
        message: 'HTTP Hatası: ${exception.message}',
        statusCode: 0,
      );
    } else if (exception.toString().contains('TimeoutException')) {
      return ApiError(
        message: 'İstek zaman aşımına uğradı (30 saniye)',
        statusCode: 408,
      );
    } else {
      return ApiError(
        message: 'Bağlantı hatası: $exception',
        statusCode: 0,
      );
    }
  }
}

/// API Response wrapper
class ApiResponse<T> {
  final T? data;
  final String? message;
  final ApiError? error;
  final bool isSuccess;

  const ApiResponse._({
    this.data,
    this.message,
    this.error,
    required this.isSuccess,
  });

  factory ApiResponse.success({
    T? data,
    String? message,
  }) {
    return ApiResponse._(
      data: data,
      message: message,
      isSuccess: true,
    );
  }

  factory ApiResponse.error(ApiError error) {
    return ApiResponse._(
      error: error,
      isSuccess: false,
    );
  }

  /// Response'un başarılı olup olmadığını kontrol eder
  bool get isError => !isSuccess;
}

/// API Error model
class ApiError {
  final String message;
  final int statusCode;
  final Map<String, dynamic>? errors;

  const ApiError({
    required this.message,
    required this.statusCode,
    this.errors,
  });

  @override
  String toString() {
    return 'ApiError(message: $message, statusCode: $statusCode, errors: $errors)';
  }
} 