import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/news/data/model/news_article_model.dart';
import '../../data/repositories/news_source_impl.dart';
import '../../domain/repositories/news_repository.dart';
import '../../data/datasources/news_remote_data_source.dart';
import '../../domain/usecases/get_techchruch_news.dart';
import '../../domain/usecases/get_tesla_news.dart';

// Provider for NewsRemoteDataSource
/// This provider must be separated
final newsRemoteDataSourceProvider = Provider<NewsRemoteDataSource>((ref) {
  // Initialize and return your NewsRemoteDataSource with Dio
  return NewsRemoteDataSource();
});



final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryImpl(ref.watch(newsRemoteDataSourceProvider));
});


// Providers for use cases
final getTeslaNewsProvider =  FutureProvider<List<Articles>>((ref) {
  return GetTeslaNews(ref.watch(newsRepositoryProvider)).call();
});

final getTechCrunchNewsProvider = FutureProvider<List<Articles>>((ref) {
  return GetTechCrunchNews(ref.watch(newsRepositoryProvider)).call();
});

final getWallStreetNewsProvider = FutureProvider<List<Articles>>((ref) {
  return GetTechCrunchNews(ref.watch(newsRepositoryProvider)).call();
});


// final getTeslaNewsProvider = FutureProvider<List<Articles>>((ref) async {
//   final dataSource = ref.watch(newsRemoteDataSourceProvider);
//   return dataSource.fetchTeslaNews();
// });
