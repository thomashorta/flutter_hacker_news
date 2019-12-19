import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/src/data/remote/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test("fetchTopIds returns a list of ids", () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final data = json.encode([1, 2, 3, 4]);
      return Response(data, 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test("fetchItem returns a ItemModel", () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {
        'id': 123,
        'title': 'Title',
        'text': 'Sample',
      };
      final data = json.encode(jsonMap);
      return Response(data, 200);
    });

    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
    expect(item.title, 'Title');
    expect(item.text, 'Sample');
  });
}
