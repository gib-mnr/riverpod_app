import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';
import '../model/news_article_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Articles>> getTechCrunchNews() async {
    return await remoteDataSource.fetchTechCrunchNews();
  }

  @override
  Future<List<Articles>> getTeslaNews() async {
    return await remoteDataSource.fetchTeslaNews();
  }

  @override
  Future<List<Articles>> getWallStreetNews() async {
    return await remoteDataSource.fetchWallStreetNews();
  }

}
