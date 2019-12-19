import 'dart:convert';

import 'package:hacker_news/src/data/models/item_model.dart';
import 'package:http/http.dart';

class NewsApiProvider {
  static const BASE_URL = 'https://hacker-news.firebaseio.com/';
  static const API_VERSION = 'v0';

  static const BASE_PATH = '$BASE_URL/$API_VERSION';

  static const ENDPOINT_TOP_IDS = 'topstories.json';
  static const ENDPOINT_ITEM = 'item';

  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get(_buildTopIdUrl());
    final ids = jsonDecode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get(_buildItemUrl(id));
    final parsedJson = jsonDecode(response.body);
    return ItemModel.fromJson(parsedJson);
  }

  static _buildTopIdUrl() => '$BASE_PATH/$ENDPOINT_TOP_IDS';
  static _buildItemUrl(int id) => '$BASE_PATH/$ENDPOINT_ITEM/$id.json';
}
