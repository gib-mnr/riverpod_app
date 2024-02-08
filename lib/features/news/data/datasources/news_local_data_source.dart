
import '../../../../core/database/database.dart';
import '../model/news_article_model.dart';

class NewsLocalDataSource {

  final AppDb _database;

  NewsLocalDataSource(this._database);

  /// Fetch Articles From Database By Type
  Future<List<ArticleEntity>> getArticlesByType(String type) async {

    // final query = _database.select(_database.articleEntities)..where((a) => a.type.equals('techcrunch'));

    // print("Query  : ${query.table.columnsByName}");

    return (_database.select(_database.articleEntities)
      ..where((article) => article.type.equals(type))
    ).get();
  }
  // Future<List<ArticleEntity>> getArticles() async {
  //   return _database.select(_database.articleEntities).get();
  // }

  /// Insert Articles into Database
  Future<void> insertArticles(List<ArticleEntity> articles) async {
    await _database.batch((batch) {
      batch.insertAllOnConflictUpdate(_database.articleEntities, articles);
    });
  }


  // Method to convert network model to database entity
  ArticleEntity _toArticleEntity(Articles article, String type) {
    return ArticleEntity(
      title: article.title ?? '',
      description: article.description,
      type: type,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
      source: article.source?.name,
      // id: 0,
    );
  }

  // This method will be called when you fetch articles from the network
  Future<void> saveArticlesFromNetwork(List<Articles> articles, String type) async {
    // final entities = articles.map(_toArticleEntity, type).toList();
    final entities = articles.map((article) => _toArticleEntity(article, type)).toList();
    await insertArticles(entities);
  }


}

