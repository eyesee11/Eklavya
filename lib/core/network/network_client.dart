import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import '../constants/api_constants.dart';
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

/// Network client for API communication
@lazySingleton
class NetworkClient {
  final Dio _dio;
  final Connectivity _connectivity;

  NetworkClient([Dio? dio, Connectivity? connectivity]) 
      : _dio = dio ?? Dio(),
        _connectivity = connectivity ?? Connectivity() {
    _setupDio();
  }

  /// Setup Dio configuration
  void _setupDio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(seconds: AppConstants.connectionTimeoutSeconds),
      receiveTimeout: Duration(seconds: AppConstants.receiveTimeoutSeconds),
      headers: {
        ApiConstants.contentTypeHeader: ApiConstants.jsonContentType,
        ApiConstants.acceptHeader: ApiConstants.jsonContentType,
        ApiConstants.userAgentHeader: '${AppConstants.appName}/${AppConstants.appVersion}',
      },
    );

    // Add interceptors
    _dio.interceptors.add(_createLoggingInterceptor());
    _dio.interceptors.add(_createAuthInterceptor());
    _dio.interceptors.add(_createErrorInterceptor());
    _dio.interceptors.add(_createRetryInterceptor());
  }

  /// Create logging interceptor for debugging
  Interceptor _createLoggingInterceptor() {
    return LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    );
  }

  /// Create authentication interceptor
  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add authentication token if available
        final token = await _getAuthToken();
        if (token != null) {
          options.headers[ApiConstants.authHeader] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        // Handle token refresh on 401 errors
        if (error.response?.statusCode == HttpStatusCodes.unauthorized) {
          final refreshed = await _refreshToken();
          if (refreshed) {
            // Retry the original request
            final retryOptions = error.requestOptions;
            final token = await _getAuthToken();
            if (token != null) {
              retryOptions.headers[ApiConstants.authHeader] = 'Bearer $token';
            }
            
            try {
              final response = await _dio.fetch(retryOptions);
              handler.resolve(response);
              return;
            } catch (e) {
              // If retry fails, continue with original error
            }
          }
        }
        handler.next(error);
      },
    );
  }

  /// Create error handling interceptor
  Interceptor _createErrorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        final exception = _handleDioError(error);
        handler.reject(DioException(
          requestOptions: error.requestOptions,
          error: exception,
          type: error.type,
          response: error.response,
        ));
      },
    );
  }

  /// Create retry interceptor
  Interceptor _createRetryInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        if (_shouldRetry(error)) {
          final retryCount = error.requestOptions.extra['retryCount'] ?? 0;
          if (retryCount < AppConstants.maxRetryAttempts) {
            error.requestOptions.extra['retryCount'] = retryCount + 1;
            
            // Wait before retry
            await Future.delayed(Duration(seconds: (retryCount + 1) * 2));
            
            try {
              final response = await _dio.fetch(error.requestOptions);
              handler.resolve(response);
              return;
            } catch (e) {
              // Continue with original error if retry fails
            }
          }
        }
        handler.next(error);
      },
    );
  }

  /// Check if request should be retried
  bool _shouldRetry(DioException error) {
    final statusCode = error.response?.statusCode;
    return error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.receiveTimeout ||
           error.type == DioExceptionType.sendTimeout ||
           statusCode == HttpStatusCodes.internalServerError ||
           statusCode == HttpStatusCodes.badGateway ||
           statusCode == HttpStatusCodes.serviceUnavailable ||
           statusCode == HttpStatusCodes.gatewayTimeout;
  }

  /// Handle Dio errors and convert to custom exceptions
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: 'Request timeout. Please check your internet connection.',
          timeout: Duration(seconds: AppConstants.connectionTimeoutSeconds),
        );
      
      case DioExceptionType.connectionError:
        return NetworkException(
          message: AppConstants.networkErrorMessage,
          code: 'CONNECTION_ERROR',
        );
      
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;
        
        if (statusCode == HttpStatusCodes.unauthorized) {
          return AuthException(
            message: 'Authentication failed',
            code: ApiErrorCodes.unauthorized,
          );
        } else if (statusCode == HttpStatusCodes.badRequest) {
          return ValidationException(
            message: responseData?['message'] ?? 'Invalid request',
          );
        } else if (statusCode == HttpStatusCodes.tooManyRequests) {
          return RateLimitException(
            message: 'Too many requests. Please try again later.',
            resetTime: responseData?['resetTime'],
          );
        } else if (statusCode != null && statusCode >= 500) {
          return ServerException(
            message: 'Server error occurred',
            code: 'SERVER_ERROR',
            statusCode: statusCode,
            data: responseData,
          );
        }
        
        return ServerException(
          message: responseData?['message'] ?? AppConstants.genericErrorMessage,
          statusCode: statusCode,
          data: responseData,
        );
      
      case DioExceptionType.cancel:
        return NetworkException(
          message: 'Request was cancelled',
          code: 'REQUEST_CANCELLED',
        );
      
      default:
        return NetworkException(
          message: AppConstants.genericErrorMessage,
          code: 'UNKNOWN_ERROR',
        );
    }
  }

  /// Check internet connectivity
  Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    if (!await hasInternetConnection()) {
      throw NetworkException(
        message: AppConstants.networkErrorMessage,
        code: 'NO_INTERNET',
      );
    }

    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    if (!await hasInternetConnection()) {
      throw NetworkException(
        message: AppConstants.networkErrorMessage,
        code: 'NO_INTERNET',
      );
    }

    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    if (!await hasInternetConnection()) {
      throw NetworkException(
        message: AppConstants.networkErrorMessage,
        code: 'NO_INTERNET',
      );
    }

    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    if (!await hasInternetConnection()) {
      throw NetworkException(
        message: AppConstants.networkErrorMessage,
        code: 'NO_INTERNET',
      );
    }

    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Upload file with progress tracking
  Future<Response<T>> uploadFile<T>(
    String path,
    String filePath, {
    String fileName = 'file',
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
  }) async {
    if (!await hasInternetConnection()) {
      throw NetworkException(
        message: AppConstants.networkErrorMessage,
        code: 'NO_INTERNET',
      );
    }

    try {
      final formData = FormData.fromMap({
        fileName: await MultipartFile.fromFile(filePath),
        if (data != null) ...data,
      });

      return await _dio.post<T>(
        path,
        data: formData,
        options: Options(
          contentType: ApiConstants.formDataContentType,
        ),
        onSendProgress: onSendProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get authentication token (implement based on your auth storage)
  Future<String?> _getAuthToken() async {
    // TODO: Implement token retrieval from secure storage
    return null;
  }

  /// Refresh authentication token
  Future<bool> _refreshToken() async {
    try {
      // TODO: Implement token refresh logic
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Cancel all pending requests
  void cancelAllRequests() {
    _dio.close(force: true);
  }
}
