import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/outshot/outshot_table.dart';

class OutshotTableService {
  static const String _tablesKey = 'outshot_tables';

  // 全てのテーブルを取得
  Future<List<OutshotTable>> getAllTables() async {
    final prefs = await SharedPreferences.getInstance();
    final tablesJson = prefs.getStringList(_tablesKey) ?? [];

    return tablesJson
        .map((json) => OutshotTable.fromJson(jsonDecode(json)))
        .toList();
  }

  // テーブルを追加
  Future<void> addTable(OutshotTable table) async {
    final prefs = await SharedPreferences.getInstance();
    final tablesJson = prefs.getStringList(_tablesKey) ?? [];

    // 既存のテーブルをチェック
    final existingTables = tablesJson
        .map((json) => OutshotTable.fromJson(jsonDecode(json)))
        .toList();

    // 同じIDのテーブルが既に存在する場合は更新
    final existingIndex = existingTables.indexWhere((t) => t.id == table.id);
    if (existingIndex != -1) {
      existingTables[existingIndex] = table;
    } else {
      existingTables.add(table);
    }

    // JSONに変換して保存
    final newTablesJson = existingTables
        .map((t) => jsonEncode(t.toJson()))
        .toList();

    await prefs.setStringList(_tablesKey, newTablesJson);
  }

  // テーブルを削除
  Future<void> deleteTable(String tableId) async {
    final prefs = await SharedPreferences.getInstance();
    final tablesJson = prefs.getStringList(_tablesKey) ?? [];

    final existingTables = tablesJson
        .map((json) => OutshotTable.fromJson(jsonDecode(json)))
        .toList();

    existingTables.removeWhere((t) => t.id == tableId);

    final newTablesJson = existingTables
        .map((t) => jsonEncode(t.toJson()))
        .toList();

    await prefs.setStringList(_tablesKey, newTablesJson);
  }

  // テーブルを更新
  Future<void> updateTable(OutshotTable table) async {
    final prefs = await SharedPreferences.getInstance();
    final tablesJson = prefs.getStringList(_tablesKey) ?? [];

    final existingTables = tablesJson
        .map((json) => OutshotTable.fromJson(jsonDecode(json)))
        .toList();

    final index = existingTables.indexWhere((t) => t.id == table.id);
    if (index == -1) {
      throw Exception('Table not found');
    }

    existingTables[index] = table;

    final newTablesJson = existingTables
        .map((t) => jsonEncode(t.toJson()))
        .toList();

    await prefs.setStringList(_tablesKey, newTablesJson);
  }

  // テーブルIDからテーブルを取得
  Future<OutshotTable?> getTableById(String tableId) async {
    final allTables = await getAllTables();
    try {
      return allTables.firstWhere((table) => table.id == tableId);
    } catch (e) {
      return null;
    }
  }

  // 新しいテーブルIDを生成
  String generateTableId() {
    return 'table_${DateTime.now().millisecondsSinceEpoch}';
  }
}
