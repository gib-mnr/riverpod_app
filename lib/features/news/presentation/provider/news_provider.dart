import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/news/data/model/news_article_model.dart';
import 'package:riverpod_app/features/news/domain/usecases/get_wallstreet_news.dart';
import '../../../../core/database/database.dart';
import '../../data/datasources/news_local_data_source.dart';
import '../../data/repositories/news_source_impl.dart';
import '../../domain/repositories/news_repository.dart';
import '../../data/datasources/news_remote_data_source.dart';
import '../../domain/usecases/get_techchruch_news.dart';
import '../../domain/usecases/get_tesla_news.dart';


final appDbProvider = Provider<AppDb>((ref) => AppDb.instance);

final newsLocalDataSourceProvider = Provider<NewsLocalDataSource>((ref) {
  final appDb = ref.watch(appDbProvider);
  return NewsLocalDataSource(appDb);
});


// Provider for NewsRemoteDataSource
/// This provider must be separated
final newsRemoteDataSourceProvider = Provider<NewsRemoteDataSource>((ref) {
  // Initialize and return your NewsRemoteDataSource with Dio
  return NewsRemoteDataSource();
});



final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  final remote = ref.watch(newsRemoteDataSourceProvider);
  final local = ref.watch(newsLocalDataSourceProvider);
  return NewsRepositoryImpl(remote, local);
});


// Providers for use cases
final getTeslaNewsProvider =  FutureProvider<List<Articles>>((ref) {
  return GetTeslaNews(ref.watch(newsRepositoryProvider)).call();
});

final getTechCrunchNewsProvider = FutureProvider<List<Articles>>((ref) {
  return GetTechCrunchNews(ref.watch(newsRepositoryProvider)).call();
});

final getWallStreetNewsProvider = FutureProvider<List<Articles>>((ref) {
  return GetWallStreetNews(ref.watch(newsRepositoryProvider)).call();
});


