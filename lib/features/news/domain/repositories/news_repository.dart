
import 'package:riverpod_app/features/news/data/model/news_article_model.dart';

abstract class NewsRepository {
  Future<List<Articles>> getTeslaNews();
  Future<List<Articles>> getTechCrunchNews();
  Future<List<Articles>> getWallStreetNews();
}
