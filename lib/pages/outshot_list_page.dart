import 'package:flutter/material.dart';
import 'package:outshotx/models/outshot/outshot_label.dart';
import 'package:outshotx/services/label_service.dart';
import 'package:outshotx/services/outshot_table_service.dart';

import '../constants/double_out_routes.dart';
import '../models/outshot/outshot_entry.dart';
import '../models/outshot/outshot_table.dart';
import 'outshot_detail_page.dart';

class OutshotListPage extends StatefulWidget {
  const OutshotListPage({super.key});

  @override
  State<OutshotListPage> createState() => _OutshotListPageState();
}

class _OutshotListPageState extends State<OutshotListPage> {
  final LabelService _labelService = LabelService();
  final OutshotTableService _tableService = OutshotTableService();
  List<OutshotLabel> _allLabels = [];
  List<OutshotTable> _tables = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final labels = await _labelService.getAllLabels();
      final tables = await _tableService.getAllTables();

      setState(() {
        _allLabels = labels;
        _tables = tables;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ダブルアウトのアウトショットを生成
  List<OutshotEntry> generateDoubleOutCombinations() {
    return DoubleOutRoutes.routes.entries
        .map(
          (entry) => OutshotEntry(
            score: entry.key,
            combination: entry.value,
            description: 'ダブルアウトルート',
          ),
        )
        .toList();
  }

  // 新規テーブル作成ダイアログを表示
  void _showCreateTableDialog() {
    final nameController = TextEditingController();
    final selectedLabels = <String>{};

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('新しいアウトショットテーブル'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'テーブル名',
                  hintText: '例: マイアウトショット',
                ),
              ),
              const SizedBox(height: 16),
              const Text('ラベルを選択:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _allLabels.map((label) {
                  final isSelected = selectedLabels.contains(label.id);
                  return FilterChip(
                    label: Text(label.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      setDialogState(() {
                        if (selected) {
                          selectedLabels.add(label.id);
                        } else {
                          selectedLabels.remove(label.id);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.trim().isNotEmpty) {
                  final newTable = OutshotTable(
                    id: _tableService.generateTableId(),
                    name: nameController.text.trim(),
                    labelIds: selectedLabels.toList(),
                    combinations: generateDoubleOutCombinations(),
                    createdAt: DateTime.now(),
                  );

                  await _tableService.addTable(newTable);
                  await _loadData(); // データを再読み込み

                  if (mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('テーブルを作成しました')),
                    );
                  }
                }
              },
              child: const Text('作成'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('アウトショット一覧')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: '新規作成',
                  onPressed: _showCreateTableDialog,
                ),
                IconButton(
                  icon: const Icon(Icons.sort),
                  tooltip: '並び替え',
                  onPressed: () {
                    // TODO: 並び替え処理
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: '編集',
                  onPressed: () {
                    // TODO: 編集モード
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: '削除',
                  onPressed: () {
                    // TODO: 削除モード
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: '検索',
                      prefixIcon: Icon(Icons.search),
                      isDense: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 8,
                      ),
                    ),
                    onChanged: (value) {
                      // TODO: 検索フィルタリング
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: _tables.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.list, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'アウトショットテーブルがありません',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '「+」ボタンから新しいテーブルを作成してください',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: _tables.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final table = _tables[index];
                      return ListTile(
                        title: Text(table.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ラベル
                            if (table.labelIds.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: Wrap(
                                  spacing: 4,
                                  runSpacing: 2,
                                  alignment: WrapAlignment.start,
                                  children: table.labelIds.map((labelId) {
                                    // 既にロード済みのラベルから検索
                                    final label = _allLabels.firstWhere(
                                      (label) => label.id == labelId,
                                      orElse: () => OutshotLabel(
                                        id: labelId,
                                        name: labelId,
                                        color: '#CCCCCC',
                                        isPredefined: false,
                                        createdAt: DateTime.now(),
                                      ),
                                    );

                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.blue.withValues(
                                            alpha: 0.3,
                                          ),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        label.name,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.blue.shade700,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            Text(
                              '作成日: ${table.createdAt.toLocal().toString().split(" ")[0]}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  OutshotDetailPage(outshotSet: table),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
