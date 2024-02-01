import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/news/data/model/news_article_model.dart';


var dio = Dio();

// final newsProvider = FutureProvider<List<Articles>>((ref) async {
//


class NewsRemoteDataSource {

  String teslaNews = 'https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&apiKey=a54cbe3ae3444efd9733a4bac98c4262';
  String techCrunchNews = 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a54cbe3ae3444efd9733a4bac98c4262';
  String wallStreetNews = 'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=a54cbe3ae3444efd9733a4bac98c4262';


  Future<List<Articles>> fetchTeslaNews() async => _fetchNewsFromUrl(teslaNews);
  Future<List<Articles>> fetchTechCrunchNews() async => _fetchNewsFromUrl(techCrunchNews);
  Future<List<Articles>> fetchWallStreetNews() async => _fetchNewsFromUrl(wallStreetNews);


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
