import 'package:hacker_news/src/data/models/item_model.dart';
import 'package:hacker_news/src/data/news_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

class NewsDbProvider implements NewsSource, NewsCache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    final path = join(documentsDir.path, 'items.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE items
          (
            id INTEGER PRIMARY KEY,
            deleted INTEGER,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            dead INTEGER,
            parent INTEGER,
            kids BLOB,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          );
        """);
      },
    );
  }

  // Todo: store and fetch top ids
  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      'items',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert(
      'items',
      item.toMapForDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> clear() {
    return db.delete('Items');
  }
}

final newsDbProvider = NewsDbProvider();
