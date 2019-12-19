import 'dart:async';

import 'package:hacker_news/src/data/local/news_db_provider.dart';
import 'package:hacker_news/src/data/models/item_model.dart';
import 'package:hacker_news/src/data/remote/news_api_provider.dart';

class NewsRepository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() async {
    return await apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);

    if (item == null) {
      item = await apiProvider.fetchItem(id);
      dbProvider.addItem(item);
    }

    return item;
  }
}