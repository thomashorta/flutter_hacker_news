import 'dart:async';

import 'package:hacker_news/src/data/local/news_db_provider.dart';
import 'package:hacker_news/src/data/models/item_model.dart';
import 'package:hacker_news/src/data/remote/news_api_provider.dart';

class NewsRepository {
  List<NewsSource> sources = <NewsSource>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<NewsCache> caches = <NewsCache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() async {
    // Todo: Iterate over sources when DbProvider implements fetchTopIds()
    return await sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    NewsSource source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    }

    for (var cache in caches) {
      if (!identical(cache, source)) cache.addItem(item);
    }

    return item;
  }

  Future clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class NewsSource {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class NewsCache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
