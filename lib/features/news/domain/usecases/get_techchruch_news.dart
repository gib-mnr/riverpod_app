import 'package:riverpod_app/features/news/data/model/news_article_model.dart';

import '../repositories/news_repository.dart';

class GetTechCrunchNews {
  final NewsRepository repository;

  GetTechCrunchNews(this.repository);

  Future<List<Articles>> call() async {
    return repository.getTechCrunchNews();
  }
}
