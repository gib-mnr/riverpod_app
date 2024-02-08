import 'dart:io';

import 'package:dio/dio.dart';

import '../const/app_strings.dart';
import 'failure.dart';


class ErrorHandler {
  static Failure handleError(dynamic error) {
    if (error is DioException) {
      // Handle DioError specifically
      return _handleDioError(error);
    } else if (error is SocketException) {
      // Handle no internet connection error
      return Failure(AppStrings.noInternetError, FailureType.internet);
    } else {
      // Handle all other types of errors
      return Failure(
        AppStrings.unexpectedError,
        FailureType.unknown,
        stackTrace: error.stackTrace,
      );
    }
  }

  static Failure _handleDioError(DioException dioError) {
    // Process the DioError to create a Failure instance
    // You might want to customize this based on the error response
    // and map it to a specific FailureType.
    return Failure(
      dioError.response?.statusMessage ?? '',
      FailureType.response,
      code: dioError.response?.statusCode,
      stackTrace: dioError.stackTrace,
    );
  }
}
