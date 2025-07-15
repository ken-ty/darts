import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/outshot/outshot_label.dart';

class LabelService {
  static const String _labelsKey = 'outshot_labels';

  // 事前定義済みのラベル
  static List<OutshotLabel> get _predefinedLabels => [
    OutshotLabel(
      id: 'double_out',
      name: 'ダブルアウト',
      color: '#FF6B6B',
      isPredefined: true,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    ),
    OutshotLabel(
      id: 'master_out',
      name: 'マスターアウト',
      color: '#4ECDC4',
      isPredefined: true,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    ),
    OutshotLabel(
      id: 'hard',
      name: 'ハード',
      color: '#45B7D1',
      isPredefined: true,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    ),
    OutshotLabel(
      id: 'soft',
      name: 'ソフト',
      color: '#96CEB4',
      isPredefined: true,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    ),
    OutshotLabel(
      id: 'beginner',
      name: '初心者',
      color: '#FFEAA7',
      isPredefined: true,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    ),
    OutshotLabel(
      id: 'intermediate',
      name: '中級者',
      color: '#DDA0DD',
      isPredefined: true,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    ),
    OutshotLabel(
      id: 'advanced',
      name: '上級者',
      color: '#FF8C42',
      isPredefined: true,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    ),
  ];

  // 全てのラベルを取得（事前定義済み + ユーザー作成）
  Future<List<OutshotLabel>> getAllLabels() async {
    final prefs = await SharedPreferences.getInstance();
    final labelsJson = prefs.getStringList(_labelsKey) ?? [];

    final userLabels = labelsJson
        .map((json) => OutshotLabel.fromJson(jsonDecode(json)))
        .toList();

    // 事前定義済みラベルとユーザー作成ラベルを結合
    final allLabels = [..._predefinedLabels, ...userLabels];

    // 作成日時でソート（新しい順）
    allLabels.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return allLabels;
  }

  // ユーザー作成ラベルのみ取得
  Future<List<OutshotLabel>> getUserLabels() async {
    final allLabels = await getAllLabels();
    return allLabels.where((label) => !label.isPredefined).toList();
  }

  // 事前定義済みラベルのみ取得
  List<OutshotLabel> getPredefinedLabels() {
    return _predefinedLabels;
  }

  // ラベルを追加
  Future<void> addLabel(OutshotLabel label) async {
    final prefs = await SharedPreferences.getInstance();
    final labelsJson = prefs.getStringList(_labelsKey) ?? [];

    // 既存のラベルをチェック
    final existingLabels = labelsJson
        .map((json) => OutshotLabel.fromJson(jsonDecode(json)))
        .toList();

    // 同じIDのラベルが既に存在する場合は更新
    final existingIndex = existingLabels.indexWhere((l) => l.id == label.id);
    if (existingIndex != -1) {
      existingLabels[existingIndex] = label;
    } else {
      existingLabels.add(label);
    }

    // JSONに変換して保存
    final newLabelsJson = existingLabels
        .map((l) => jsonEncode(l.toJson()))
        .toList();

    await prefs.setStringList(_labelsKey, newLabelsJson);
  }

  // ラベルを削除
  Future<void> deleteLabel(String labelId) async {
    final prefs = await SharedPreferences.getInstance();
    final labelsJson = prefs.getStringList(_labelsKey) ?? [];

    final existingLabels = labelsJson
        .map((json) => OutshotLabel.fromJson(jsonDecode(json)))
        .toList();

    // 事前定義済みラベルも削除可能
    final labelToDelete = existingLabels.firstWhere(
      (l) => l.id == labelId,
      orElse: () => throw Exception('Label not found'),
    );

    existingLabels.removeWhere((l) => l.id == labelId);

    final newLabelsJson = existingLabels
        .map((l) => jsonEncode(l.toJson()))
        .toList();

    await prefs.setStringList(_labelsKey, newLabelsJson);
  }

  // ラベルを更新
  Future<void> updateLabel(OutshotLabel label) async {
    final prefs = await SharedPreferences.getInstance();
    final labelsJson = prefs.getStringList(_labelsKey) ?? [];

    final existingLabels = labelsJson
        .map((json) => OutshotLabel.fromJson(jsonDecode(json)))
        .toList();

    final index = existingLabels.indexWhere((l) => l.id == label.id);
    if (index == -1) {
      throw Exception('Label not found');
    }

    // 事前定義済みラベルも編集可能
    existingLabels[index] = label;

    final newLabelsJson = existingLabels
        .map((l) => jsonEncode(l.toJson()))
        .toList();

    await prefs.setStringList(_labelsKey, newLabelsJson);
  }

  // ラベルIDからラベルを取得
  Future<OutshotLabel?> getLabelById(String labelId) async {
    final allLabels = await getAllLabels();
    try {
      return allLabels.firstWhere((label) => label.id == labelId);
    } catch (e) {
      return null;
    }
  }

  // ラベル名からラベルを取得
  Future<OutshotLabel?> getLabelByName(String name) async {
    final allLabels = await getAllLabels();
    try {
      return allLabels.firstWhere((label) => label.name == name);
    } catch (e) {
      return null;
    }
  }

  // 新しいラベルIDを生成
  String generateLabelId() {
    return 'label_${DateTime.now().millisecondsSinceEpoch}';
  }
}
