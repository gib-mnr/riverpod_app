import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import '../errors/failure.dart';
import 'http_service.dart';
import 'interceptors/api_interceptor.dart';

/// Http service implementation using the Dio package
/// See https://pub.dev/packages/dio

class HttpServiceImpl implements HttpService {
  /// The Dio Http client
  late final Dio dio;

  /// Creates new instance of [HttpServiceImpl]
  HttpServiceImpl() {
    dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor());
  }

  @override
  String get baseUrl => 'https://medisaga.com/api';

  @override
  Map<String, String> headers = {
    'accept': 'application/json',
    'content-type': 'application/json',
    // 'Content-Type': 'multipart/form-data',
  };

  /// The Dio base options
  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 5),
      );

  @override
  Future<Either<Failure, Response<dynamic>>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    String? customBaseUrl,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response<dynamic> response = await dio.get<Map<String, dynamic>>(
        endpoint,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.toFailure);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Response<dynamic>>> post(String endpoint,
      {Map<String, dynamic>? queryParameters,
      FormData? formData,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      }) async {
    try {
      final Response<dynamic> response = await dio.post(endpoint,
          data: formData,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure.fromException(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Response<dynamic>>> delete(
    String endpoint, {
    CancelToken? cancelToken,
  }) async {
    try {
      final Response<dynamic> response = await dio.delete(
        endpoint,
        cancelToken: cancelToken,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure.fromException(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Response>> patch(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    FormData? formData,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response<dynamic> response = await dio.patch(
        endpoint,
        cancelToken: cancelToken,
        data: formData,
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure.fromException(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
