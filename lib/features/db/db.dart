import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

const String tableResult = 'results';
const String columnId = 'id';
const String columnTotal = 'total';
const String columnCount = 'count';
const String columnAverage = 'average';
late Database _database;

class DbHelper {
  static const _keyTotal = 'total';
  static const _keyCount = 'count';
  static const _keyAverage = 'average';

  Future<Database> get _database async {
    return await openDatabase(
      'my_database.db',
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $tableResult (
          $columnId INTEGER PRIMARY KEY,
          $columnTotal INTEGER,
          $columnCount INTEGER,
          $columnAverage REAL
        )
      ''');
      },
    );
  }

  Future<void> saveResult(int total, int count, double average) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the existing result from SharedPreferences
    final resultsJson = prefs.getString('results') ?? '[]';
    final List<dynamic> resultsData = json.decode(resultsJson);
    final List<Result> results =
        resultsData.map((resultJson) => Result.fromJson(resultJson)).toList();

    // Add a new result to the existing list or create a new list with the new result
    if (results.isNotEmpty) {
      final lastResult = results.last;
      if (lastResult.total == total &&
          lastResult.count == count &&
          lastResult.average == average) {
        return; // Return if the last result is the same as the new one
      }
    }

    final newResult = Result(total, count, average);
    results.add(newResult);

    // Save the updated list of results to SharedPreferences
    final updatedResultsJson =
        json.encode(results.map((result) => result.toJson()).toList());
    await prefs.setString('results', updatedResultsJson);

    // Save the result to the database
    final db = await _database;
    await db.insert(tableResult, newResult.toMap());
  }

  Future<List<Record>> getResult() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query(tableResult);
    final List<Record> results =
        List.generate(maps.length, (i) => Record.fromMap(maps[i]));
    return results;
  }

  Future<void> deleteResult() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyTotal);
    await prefs.remove(_keyCount);
    await prefs.remove(_keyAverage);

    final db = await _database;
    await db.delete(tableResult);
  }

  Future<void> deleteRecord(int id) async {
    final db = await _database;
    await db.delete(tableResult, where: '$columnId = ?', whereArgs: [id]);

    final prefs = await SharedPreferences.getInstance();
    final resultsJson = prefs.getString('results') ?? '[]';
    final List<dynamic> resultsData = json.decode(resultsJson);
    final List<Result> results =
        resultsData.map((resultJson) => Result.fromJson(resultJson)).toList();
    results.removeWhere((result) => result.total == id);
    final updatedResultsJson =
        json.encode(results.map((result) => result.toJson()).toList());
    await prefs.setString('results', updatedResultsJson);
  }
}

class Result {
  final int total;
  final int count;
  final double average;

  Result(this.total, this.count, this.average);

  Result.fromJson(Map<String, dynamic> json)
      : total = json['total'],
        count = json['count'],
        average = json['average'];

  Map<String, dynamic> toJson() => {
        'total': total,
        'count': count,
        'average': average,
      };

  Map<String, dynamic> toMap() => {
        columnTotal: total,
        columnCount: count,
        columnAverage: average,
      };
}

class Record {
  int? id; // add this line to define an id property

  int total;
  int count;
  double average;

  Record({required this.total, required this.count, required this.average});

  // add this method to create a Record object from a Map
  Record.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        total = map[columnTotal],
        count = map[columnCount],
        average = map[columnAverage];

  // add this method to convert a Record object to a Map
  Map<String, dynamic> toMap() => {
        columnId: id,
        columnTotal: total,
        columnCount: count,
        columnAverage: average,
      };
}
