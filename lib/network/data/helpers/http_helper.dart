import 'package:articles_app/core/core.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class HttpHelper {
  void initHttpClient();

  void updateAuthToken(String token);

  Future<Response<dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    String? packageName,
  });

  Future<Response<dynamic>> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future<Response<dynamic>> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future<Response<dynamic>> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future<Response<dynamic>> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future<Response<dynamic>> getWithCustomUrl(
    String baseUrl,
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Options? dioOptions,
    Interceptor? dioInterceptor,
    bool removeAuth = false,
  });

  Future<Response<dynamic>> postWithCustomUrl(
    String baseUrl,
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Options? dioOptions,
    Interceptor? dioInterceptor,
  });

  Future<Response<dynamic>> putWithCustomUrl(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Options? dioOptions,
    Interceptor? dioInterceptor,
  });
}

class HttpHelperImpl extends HttpHelper {
  HttpHelperImpl({
    required this.baseURL,
    required this.dio,
    this.connectionTimeout = const Duration(seconds: 15),
    this.receiveTimeout = const Duration(seconds: 15),
    this.logBody = true,
  });

  final String baseURL;
  final Dio dio;
  final Duration connectionTimeout;
  final Duration receiveTimeout;
  final bool logBody;

  @override
  void initHttpClient() {
    dio
      ..options.baseUrl = baseURL
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.responseType = ResponseType.json
      ..interceptors.add(
        PrettyDioLogger(requestHeader: true, requestBody: logBody),
      )
      ..interceptors.add(CurlLoggerDioInterceptor())
      ..interceptors.add(
        InterceptorsWrapper(
          onError: (DioException error, ErrorInterceptorHandler handler) {
            // Checking api timeout
            if (error.type == DioExceptionType.receiveTimeout) {
              throw const ServerException();
            }

            // Checking network connection
            if (error.type == DioExceptionType.connectionTimeout) {
              throw const ServerException();
            }

            // Checking exceptions from API calls
            if (error.response != null) {
              final responseData = error.response!.data as Map<String, dynamic>;

              if (error.response!.statusCode == 401) {
                throw AuthException(
                  code: error.response!.statusCode ?? 401,
                  message:
                      (responseData['error'] as Map<String, dynamic>)['msg']
                          as String,
                );
              }

              if (error.response != null) {
                if (error.response!.statusCode! >= 400 &&
                    error.response!.statusCode! <= 500) {
                  throw ServerException(
                    code: responseData['code'] as int,
                    message:
                        responseData['errors'] != null
                            ? (responseData['errors'] as List<dynamic>)
                                        .firstOrNull['message']
                                    as String? ??
                                'Something went wrong!'
                            : responseData['message'] as String? ??
                                'Something went wrong!',
                  );
                }
              }
            } else {
              throw ServerException(
                code: error.response?.statusCode ?? 400,
                message: error.type.toString(),
              );
            }

            handler.reject(error);
          },
        ),
      );
  }

  @override
  void updateAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  Future<Response<dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    String? packageName,
  }) async {
    try {
      if (packageName != null) {
        dio.options.headers['X-ApplicationId'] = packageName;
      }
      final response = await dio.get<dynamic>(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (packageName != null) {
        dio.options.headers.remove('X-ApplicationId');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.post<dynamic>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.put<dynamic>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.patch<dynamic>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.delete<dynamic>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> getWithCustomUrl(
    String baseUrl,
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Options? dioOptions,
    Interceptor? dioInterceptor,
    bool removeAuth = false,
  }) async {
    try {
      final customDio = Dio(dio.options.copyWith(baseUrl: baseUrl));
      customDio.interceptors.add(
        PrettyDioLogger(requestHeader: true, requestBody: logBody),
      );
      customDio.interceptors.add(
        CurlLoggerDioInterceptor(printOnSuccess: true),
      );
      if (removeAuth) {
        customDio.options = customDio.options..headers.remove('Authorization');
      }
      final response = await customDio.get<dynamic>(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> postWithCustomUrl(
    String baseUrl,
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Options? dioOptions,
    Interceptor? dioInterceptor,
  }) async {
    try {
      final customDio = Dio(dio.options.copyWith(baseUrl: baseUrl));
      customDio.interceptors.add(
        PrettyDioLogger(requestHeader: true, requestBody: logBody),
      );

      final response = await customDio.post<dynamic>(
        url,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> putWithCustomUrl(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Options? dioOptions,
    Interceptor? dioInterceptor,
  }) async {
    try {
      final response = await Dio().put<dynamic>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
