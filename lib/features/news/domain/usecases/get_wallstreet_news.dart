import 'package:riverpod_app/features/news/data/model/news_article_model.dart';

import '../repositories/news_repository.dart';

class GetWallStreetNews {
  final NewsRepository repository;

  GetWallStreetNews(this.repository);

  Future<List<Articles>> call() async {
    return repository.getWallStreetNews();
  }
}
