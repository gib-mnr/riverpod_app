// get_tesla_news.dart

import 'package:riverpod_app/features/news/data/model/news_article_model.dart';

import '../repositories/news_repository.dart';

class GetTeslaNews {

  final NewsRepository repository;
  GetTeslaNews(this.repository);

  Future<List<Articles>> call() async {
    return repository.getTeslaNews();
  }


}
