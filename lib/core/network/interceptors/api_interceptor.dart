import 'dart:developer';
import 'package:dio/dio.dart';

class NetworkInterceptor implements Interceptor {

  String? _accessToken;
  DateTime? _accessTokenExpirationTime;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    log('❌ ❌ ❌ Dio Error!');
    log('❌ ❌ ❌ Url: ${err.requestOptions.uri}');
    log('❌ ❌ ❌ ${err.stackTrace}');
    log('❌ ❌ ❌ Response Errors: ${err.response?.data}');

    // Check if the error indicates an expired token.
    if (err.response?.statusCode == 401) {
      // Refresh the access token.
      //   await refreshToken();
      // Retry the request with the updated access token.
      // return handler.next(err);
    }

    return handler.next(err);
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    if(_accessToken==null ||_accessToken!.isEmpty){
      // _accessToken = await hive.getAccessToken();
    }

    /// Logging:
    log('🌍 🌍 🌍 Retrieving request from network');
    log('Url: ${options.uri}');
    log('Params: ${options.queryParameters}');
    // Check if the access token is expired.
    if (isAccessTokenExpired()) {
      // Refresh the access token.
      // await refreshToken();
      // Update the request headers with the new access token.
      options.headers['Authorization'] = 'Bearer $_accessToken';
    }
    else{
      if(_accessToken!=null && _accessToken!.isNotEmpty){
        options.headers['Authorization'] = 'Bearer $_accessToken';
      }
      log('Params: ${options.headers}');

    }


    // Continue with the request.
    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    log('🌍 🌍 🌍 Retrieved response from network');
    log('⬅️ ⬅️ ⬅️ Response');
    log('''<---- ${(response.statusCode != 200 || response.statusCode != 201) ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}''');
    log('Query params: ${response.requestOptions.queryParameters}');
    log('-------------------------');
    return handler.next(response);
  }

  Future<void> refreshToken() async {
    // Make a request to the server to get a new access token.
    // Update the access token and expiration time.
    final response = await Dio().post(
        'path',
        data: {
          'refresh_token': '<your_refresh_token>',
          // Replace with your actual refresh token
        }
    );
    // Check if the response is successful
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Extract the new access token from the response
      final newAccessToken = response.data['access_token'];
      _accessToken = newAccessToken;
      _accessTokenExpirationTime =
          DateTime.now().add(const Duration(seconds: 36000));
      // Set expiration time to 1 hour from now
    }
    else {
      // Handle error response
      print('Error refreshing access token: ${response.statusCode}');
    }

  }


  bool isAccessTokenExpired() {
    return false;
    // Check if the access token is not null and has an expiration time.
    if (_accessToken != null && _accessTokenExpirationTime != null) {
      // Compare the current time to the expiration time.
      return DateTime.now().isAfter(_accessTokenExpirationTime!);
    } else {
      // If there's no token or expiration time, consider it expired.
      return true;
    }
  }


}
