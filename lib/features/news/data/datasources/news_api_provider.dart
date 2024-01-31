import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/news/data/model/news_article_model.dart';


var dio = Dio();

final newsProvider = FutureProvider<List<Articles>>((ref) async {

  final response = await dio.get('https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a54cbe3ae3444efd9733a4bac98c4262');

  print("Inside News Provider");
  print("Inside News Provider : ${response.statusCode}");

  if (response.statusCode == 200) {
    var articles = response.data;
    print("Articles : ${articles.toString()}");
      return NewsArticleModel.fromJson(articles).articles ?? [];
  } else {
    throw Exception('Failed to load news');
  }
});
