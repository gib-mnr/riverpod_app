import 'package:dio/dio.dart';
import 'package:riverpod_app/features/news/data/model/news_article_model.dart';

import '../../../../core/const/app_strings.dart';


var dio = Dio();


class NewsRemoteDataSource {


  Future<List<Articles>> fetchTeslaNews() async => _fetchNewsFromUrl(AppStrings.teslaNews);
  Future<List<Articles>> fetchTechCrunchNews() async => _fetchNewsFromUrl(AppStrings.techCrunchNews);
  Future<List<Articles>> fetchWallStreetNews() async => _fetchNewsFromUrl(AppStrings.wallStreetNews);


  Future<List<Articles>> _fetchNewsFromUrl(String url) async {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      var articles = response.data;
      print("Articles : ${articles.toString()}");
      return NewsArticleModel.fromJson(articles).articles ?? [];
    } else {
      return [];
    }
  }
}
