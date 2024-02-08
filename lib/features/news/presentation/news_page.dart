import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/database/database_provider.dart';
import 'package:riverpod_app/features/news/presentation/widgets/tech_cruch_newspage.dart';
import 'package:riverpod_app/features/news/presentation/widgets/wallstreet_news_page.dart';
import 'widgets/tesla_news_page.dart';
// Implement this

class NewsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // DatabaseProvider databaseProvider = DatabaseProvider();
    // databaseProvider.insertData();


    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('News Categories'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Tesla'),
              Tab(text: 'TechCrunch'),
              Tab(text: 'Wall Street'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TeslaNewsPage(), // Implement this widget to display Tesla news
            TechCrunchNewsPage(), // Implement this widget to display Tesla news
            WallStreetNewsPage(), // Implement this widget to display Tesla news
          ],
        ),
      ),
    );
  }
}
