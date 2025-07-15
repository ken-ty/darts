import 'package:flutter/material.dart';
import 'package:outshotx/constants/feature_flags.dart';
import 'package:outshotx/l10n/app_localizations.dart';
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
            description: AppLocalizations.of(context)?.doubleOutRoute ?? '',
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
          title: Text(AppLocalizations.of(context)?.newOutshotTable ?? ''),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.tableName ?? '',
                  hintText: AppLocalizations.of(context)?.tableNameHint ?? '',
                ),
              ),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context)?.selectLabels ?? ''),
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
              child: Text(AppLocalizations.of(context)?.cancel ?? ''),
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
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)?.tableCreated ?? '',
                        ),
                      ),
                    );
                  }
                }
              },
              child: Text(AppLocalizations.of(context)?.create ?? ''),
            ),
          ],
        ),
      ),
    );
  }

  // テーブル編集ダイアログを表示
  void _showEditTableDialog(OutshotTable table) {
    final nameController = TextEditingController(text: table.name);
    final selectedLabels = <String>{...table.labelIds};

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(AppLocalizations.of(context)?.editTable ?? ''),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.tableName ?? '',
                  hintText: AppLocalizations.of(context)?.tableNameHint ?? '',
                ),
              ),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context)?.selectLabels ?? ''),
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
              child: Text(AppLocalizations.of(context)?.cancel ?? ''),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.trim().isNotEmpty) {
                  final updatedTable = OutshotTable(
                    id: table.id,
                    name: nameController.text.trim(),
                    labelIds: selectedLabels.toList(),
                    combinations: table.combinations,
                    createdAt: table.createdAt,
                  );

                  await _tableService.updateTable(updatedTable);
                  await _loadData(); // データを再読み込み

                  if (mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)?.tableUpdated ?? '',
                        ),
                      ),
                    );
                  }
                }
              },
              child: Text(AppLocalizations.of(context)?.update ?? ''),
            ),
          ],
        ),
      ),
    );
  }

  // テーブル削除確認ダイアログを表示
  void _showDeleteConfirmDialog(OutshotTable table) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.deleteTable ?? ''),
        content: Text(
          AppLocalizations.of(context)?.deleteTableConfirm(table.name) ?? '',
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)?.cancel ?? ''),
          ),
          ElevatedButton(
            onPressed: () async {
              await _tableService.deleteTable(table.id);
              await _loadData(); // データを再読み込み

              if (mounted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)?.tableDeleted ?? '',
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(AppLocalizations.of(context)?.delete ?? ''),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.outshotList ?? ''),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: AppLocalizations.of(context)?.createNew ?? '',
            onPressed: _showCreateTableDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          if (FeatureFlags.enableOutshotTableSearch) ...[
            // 検索バー
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.searchTableName ?? '',
                  prefixIcon: const Icon(Icons.search),
                  isDense: true,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
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
          const Divider(height: 1),
          Expanded(
            child: _tables.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.list, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)?.noOutshotTables ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(
                                context,
                              )?.noOutshotTablesDescription ??
                              '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: _tables.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final table = _tables[index];
                      return Dismissible(
                        key: Key(table.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (direction) async {
                          _showDeleteConfirmDialog(table);
                          return false; // 手動でダイアログを表示するため
                        },
                        child: ListTile(
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
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                                AppLocalizations.of(context)?.createdDate(
                                      table.createdAt
                                          .toLocal()
                                          .toString()
                                          .split(" ")[0],
                                    ) ??
                                    '',
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
                          onLongPress: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.edit),
                                    title: Text(
                                      AppLocalizations.of(context)?.edit ?? '',
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _showEditTableDialog(table);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.copy),
                                    title: Text(
                                      AppLocalizations.of(context)?.duplicate ??
                                          '',
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      // TODO: 複製機能
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    title: Text(
                                      AppLocalizations.of(context)?.delete ??
                                          '',
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _showDeleteConfirmDialog(table);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
