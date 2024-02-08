import 'package:riverpod_app/core/const/app_strings.dart';
import 'package:riverpod_app/core/network/api_endpoints.dart';
import 'package:riverpod_app/features/news/data/model/news_article_model.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/http_service.dart';

class NewsRemoteDataSource {
  final HttpService _httpService;

  NewsRemoteDataSource(this._httpService);

  Future<List<Articles>> fetchTeslaNews() async =>
      _fetchNewsFromUrl(ApiEndPoints.teslaNews);

  Future<List<Articles>> fetchTechCrunchNews() async =>
      _fetchNewsFromUrl(ApiEndPoints.techCrunchNews);

  Future<List<Articles>> fetchWallStreetNews() async =>
      _fetchNewsFromUrl(ApiEndPoints.wallStreetNews);


  Future<List<Articles>> _fetchNewsFromUrl(String url) async {
    final result = await _httpService.get(url);
    return result.fold(
      (failure) {
        // Use ErrorHandler to process the failure
        final processedFailure = ErrorHandler.handleError(failure);
        // Depending on your app's design, you might want to log the error,
        // show a user-friendly message, or perform some other action.
        // For the sake of this example, we'll just print the error.
        print(processedFailure.reason);
        // Decide what to do: throw an error or return an empty list
        // Here we choose to throw an error
        throw processedFailure;
        },
        // After handling, return an empty list or throw an error
        // This depends on whether your UI can handle an empty list or expects to catch an error
        // return [];
      // },
      (response) {
        // Assuming your JSON top-level field is 'articles' and it's a list
        if (response.statusCode == 200) {
          final articlesJson = response.data;
          return NewsArticleModel.fromJson(articlesJson).articles ?? [];
        } else {
          // Handle unexpected response format
          throw Failure(
            AppStrings.unexpectedError,
            FailureType.badResponse,
            code: response.statusCode,
          );
        }
      },
    );
  }
}
