import 'dart:math';

import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/features/numbers/data/models/number_trivia_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class NumbersLocalDataSource {
  Future<void> cacheNumberTrivia(int number, String text, String category, String data);

  Future<void> saveNumberTrivia(int number, String text, String category, String data);

  Future<List<NumberTriviaModel>> getAllSavedNumberTrivia();

  Future<void> unSaveNumberTrivia(int triviaId);

  Future<NumberTriviaModel> getLastNumberTrivia({required String number, required InformationTypes category});

  Future<NumberTriviaModel> getRandomNumberTrivia({required InformationTypes category});

  Future<void> clearCache();
}

class NumbersLocalDataSourceImpl implements NumbersLocalDataSource {
  static const _tableName = 'number_trivia';
  static const _savedTableName = 'saved_number_trivia';
  static const _dbName = 'numbers.db';

  Database? _database;

  Future<Database> get _db async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _dbName);

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            number INTEGER,
            data TEXT,
            text TEXT,
            category TEXT,
            createdAt TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE $_savedTableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            number INTEGER,
            data TEXT,
            text TEXT,
            category TEXT,
            createdAt TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<void> cacheNumberTrivia(int number, String text, String category, String data) async {
    final db = await _db;
    await db.insert(
      _tableName,
      {
        'number': number,
        'data': data,
        'text': text,
        'category': category,
        'createdAt': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<NumberTriviaModel>> getAllSavedNumberTrivia() async {
    final db = await _db;
    final maps = await db.query(_savedTableName, orderBy: 'createdAt DESC');

    return maps
        .map((e) => NumberTriviaModel(
              data: e['data'] as String,
              text: e['text'] as String,
              category: e['category'] as String,
              number: e['number'] as int,
              id: e['id'] as int? ?? -1,
              isSaved: true,
            ))
        .toList();
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia({
    required String number,
    required InformationTypes category,
  }) async {
    final db = await _db;

    final maps = await db.query(
      _tableName,
      where: 'data = ? AND category = ?',
      whereArgs: [number, category.key],
      orderBy: 'createdAt DESC',
      limit: 1,
    );

    if (maps.isEmpty) throw Exception('No cached trivia found');

    final random = Random();
    final e = maps[random.nextInt(maps.length)];

    return NumberTriviaModel(
      number: e['number'] as int,
      text: e['text'] as String,
      category: e['category'] as String,
    );
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia({
    required InformationTypes category,
  }) async {
    final db = await _db;

    final maps = await db.query(
      _tableName,
      where: 'category = ?',
      whereArgs: [category.key],
      orderBy: 'createdAt DESC',
      limit: 1,
    );

    if (maps.isEmpty) throw Exception('No cached trivia found');

    final random = Random();
    final e = maps[random.nextInt(maps.length)];

    return NumberTriviaModel(
      number: e['number'] as int,
      text: e['text'] as String,
      category: e['category'] as String,
    );
  }

  @override
  Future<void> clearCache() async {
    final db = await _db;
    await db.delete(_tableName);
  }

  @override
  Future<void> saveNumberTrivia(int number, String text, String category, String data) async {
    final db = await _db;
    await db.insert(
      _savedTableName,
      {
        'number': number,
        'data': data,
        'text': text,
        'category': category,
        'createdAt': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> unSaveNumberTrivia(int triviaID) async {
    final db = await _db;
    await db.delete(
      _savedTableName,
      where: 'id = ? ',
      whereArgs: [triviaID],
    );
  }
}
