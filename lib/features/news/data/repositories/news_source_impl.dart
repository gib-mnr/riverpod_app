import '../../../../core/database/database.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_local_data_source.dart';
import '../datasources/news_remote_data_source.dart';
import '../model/news_article_model.dart';

class NewsRepositoryImpl implements NewsRepository {

  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  NewsRepositoryImpl(this.remoteDataSource, this.localDataSource);

  List<String> newsType =  ['techcrunch', 'tesla', 'wallstreet'];

  // Check if you have internet connection
  // If yes, fetch from remote and store to local
  // If no, fetch from local
  // This is a simplified logic

  @override
  Future<List<Articles>> getTechCrunchNews() async {
    try {
      // Attempt to fetch TechCrunch news from remote source
      final articles = await remoteDataSource.fetchTechCrunchNews();
      // Optionally, save to local database for offline access
      await localDataSource.saveArticlesFromNetwork(articles, newsType.first);
      // double a = 4/0;
      // print(a);
      return articles;
    } catch (_) {
      print("Catch Tech Chrunch");
      // On failure, fetch from local database
      final localArticlesEntities = await localDataSource.getArticlesByType(newsType.first);
      return localArticlesEntities.map(_toArticle).toList();
    }
  }


  @override
  Future<List<Articles>> getTeslaNews() async {
    try {
      // Attempt to fetch Tesla news from remote source
      final articles = await remoteDataSource.fetchTeslaNews();
      // Optionally, save to local database for offline access
      await localDataSource.saveArticlesFromNetwork(articles, newsType[1]);
      return articles;
    } catch (_) {
      // On failure, fetch from local database
      final localArticlesEntities = await localDataSource.getArticlesByType(newsType[1]);
      return localArticlesEntities.map(_toArticle).toList();
    }
  }

  @override
  Future<List<Articles>> getWallStreetNews() async {
    try {
      // Attempt to fetch Wall Street news from remote source
      final articles = await remoteDataSource.fetchWallStreetNews();
      // Optionally, save to local database for offline access
      await localDataSource.saveArticlesFromNetwork(articles, newsType.last);
      return articles;
    } catch (_) {
      // On failure, fetch from local database
      final localArticlesEntities = await localDataSource.getArticlesByType(newsType.last);
      return localArticlesEntities.map(_toArticle).toList();
    }
  }

  // Helper method to convert from database entity to network model
  Articles _toArticle(ArticleEntity entity) {
    return Articles(
      // Assuming you have a way to construct `Source` from a string
      source: Source(name: entity.source),
      title: entity.title,
      description: entity.description,
      url: entity.url,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
      content: entity.content,
    );
  }

}
