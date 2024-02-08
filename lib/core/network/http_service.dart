import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import '../errors/failure.dart';

/// Http Service Interface
abstract class HttpService {
  /// Http base url
  String get baseUrl;

  /// Http headers
  Map<String, String> get headers;

  /// Http get request
  Future<Either<Failure, Response<dynamic>>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });

  /// Http post request
  Future<Either<Failure, Response<dynamic>>> post(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    FormData? formData,
    ProgressCallback? onSendProgress,
  });

  /// Http put request
  Future<Either<Failure, Response<dynamic>>> patch(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    FormData? formData,
  });

  /// Http delete request
  Future<Either<Failure, Response<dynamic>>> delete(
    String endpoint, {
    CancelToken? cancelToken,
  });
}
