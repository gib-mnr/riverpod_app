import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/news_provider.dart';

class WallStreetNewsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncWallStreetNews = ref.watch(getWallStreetNewsProvider);

    return asyncWallStreetNews.when(
      data: (articles) => ListView.separated(
        itemCount: articles.length,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(articles[index].title ?? ''),
                  subtitle: Text(articles[index].description ?? 'No description available', textAlign: TextAlign.justify,),
                ),
                Container(
                  height: 200,
                  width: double.maxFinite,
                  child:      ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child:  Image.network(
                      articles[index].urlToImage ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        // You can return any widget here. For example, an Icon or an Image.asset if you have a placeholder image.
                        return Icon(Icons.error); // This will display an error icon if the image cannot be loaded.
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox.shrink();
        },
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error loading news')),
    );
  }
}
