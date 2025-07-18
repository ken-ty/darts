import 'dart:convert';
import 'dart:typed_data';

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

  /// テーブルを複製
  /// [tableId] 複製元のテーブルID
  /// [suffix] 複製後のテーブル名の末尾に付与する文字列
  /// [separator] 複製後のテーブル名と末尾の文字列をつなぐ文字列
  Future<OutshotTable> duplicateTable(
    String tableId,
    String suffix, {
    String separator = ' ',
  }) async {
    final originalTable = await getTableById(tableId);
    if (originalTable == null) {
      throw Exception('Table not found');
    }

    // 新しいIDを生成
    final newId = generateTableId();

    // 複製元のデータをコピーして新しいテーブルを作成
    final duplicatedTable = OutshotTable(
      id: newId,
      name: '${originalTable.name}$separator$suffix',
      labelIds: List<String>.from(originalTable.labelIds),
      combinations: originalTable.combinations.map((entry) => entry).toList(),
      createdAt: DateTime.now(),
    );

    // 新しいテーブルを保存
    await addTable(duplicatedTable);

    return duplicatedTable;
  }

  /// 全データを削除（アプリ初期化用）
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tablesKey);
  }

  /// テーブルをJSONバイトデータにシリアライズ（純粋なビジネスロジック）
  Future<Uint8List> serializeTable(
    OutshotTable table, {
    String errorMessage = 'Failed to serialize table',
  }) async {
    try {
      final jsonString = jsonEncode(table.toJson());
      return Uint8List.fromList(utf8.encode(jsonString));
    } catch (e) {
      throw Exception('$errorMessage: $e');
    }
  }

  /// テーブル用のファイル名を生成（純粋なビジネスロジック）
  String generateTableFileName(OutshotTable table) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${table.name.replaceAll(RegExp(r'[^\w+-]'), '_')}_$timestamp.json';
  }

  /// バイトデータからテーブルをデシリアライズ（純粋なビジネスロジック）
  Future<OutshotTable> deserializeTable(
    Uint8List bytes, {
    String errorMessage = 'Failed to deserialize table',
  }) async {
    try {
      final jsonString = utf8.decode(bytes);
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      // JSONからテーブルを作成
      final importedTable = OutshotTable.fromJson(jsonData);

      // 新しいIDを生成（重複を避けるため）
      final newTable = OutshotTable(
        id: generateTableId(),
        name: importedTable.name,
        labelIds: importedTable.labelIds,
        combinations: importedTable.combinations,
        createdAt: DateTime.now(),
      );

      return newTable;
    } catch (e) {
      throw Exception('$errorMessage: $e');
    }
  }

  /// テーブル名の重複チェック
  Future<bool> isTableNameExists(String tableName) async {
    final allTables = await getAllTables();
    return allTables.any((table) => table.name == tableName);
  }

  /// 重複するテーブル名を解決
  String resolveDuplicateTableName(String originalName) {
    int counter = 1;
    String newName = originalName;

    while (true) {
      final testName = '$originalName ($counter)';
      // 実際のチェックは呼び出し側で行うため、ここでは名前の生成のみ
      if (counter > 100) break; // 無限ループ防止
      newName = testName;
      counter++;
    }

    return newName;
  }
}
