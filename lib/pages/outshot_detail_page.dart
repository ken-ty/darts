import 'package:flutter/material.dart';
import 'package:outshotx/constants/feature_flags.dart';
import 'package:outshotx/l10n/app_localizations.dart';

import '../models/outshot/outshot_entry.dart';
import '../models/outshot/outshot_table.dart';

class OutshotDetailPage extends StatefulWidget {
  final OutshotTable outshotSet;

  const OutshotDetailPage({super.key, required this.outshotSet});

  @override
  State<OutshotDetailPage> createState() => _OutshotDetailPageState();
}

class _OutshotDetailPageState extends State<OutshotDetailPage> {
  String _searchQuery = '';

  List<OutshotEntry> get _filteredCombinations {
    var combinations = widget.outshotSet.combinations;

    // 検索フィルタリング
    if (_searchQuery.isNotEmpty) {
      combinations = combinations.where((combo) {
        return combo.score.toString().contains(_searchQuery) ||
            combo.description.contains(_searchQuery) ||
            combo.combination.any((dart) => dart.contains(_searchQuery));
      }).toList();
    }

    // スコア順（降順）でソート
    combinations.sort((a, b) => b.score.compareTo(a.score));

    return combinations;
  }

  // Entry追加ダイアログ
  Future<void> _showEntryDialog({OutshotEntry? entry, int? editIndex}) async {
    final scoreController = TextEditingController(
      text: entry?.score.toString() ?? '',
    );
    final combinationController = TextEditingController(
      text: entry?.combination.join(',') ?? '',
    );
    final descriptionController = TextEditingController(
      text: entry?.description ?? '',
    );

    final result = await showDialog<OutshotEntry>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          entry == null
              ? AppLocalizations.of(context)?.addEntry ?? ''
              : AppLocalizations.of(context)?.editEntry ?? '',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: scoreController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.score ?? '',
              ),
            ),
            TextField(
              controller: combinationController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.combination ?? '',
                hintText: AppLocalizations.of(context)?.combinationHint ?? '',
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.description ?? '',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)?.cancel ?? ''),
          ),
          ElevatedButton(
            onPressed: () {
              final entry = OutshotEntry(
                score: int.tryParse(scoreController.text) ?? 0,
                combination: combinationController.text
                    .split(',')
                    .map((e) => e.trim())
                    .toList(),
                description: descriptionController.text,
              );
              Navigator.pop(context, entry);
            },
            child: Text(AppLocalizations.of(context)?.save ?? ''),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        if (editIndex != null) {
          widget.outshotSet.combinations[editIndex] = result;
        } else {
          widget.outshotSet.combinations.add(result);
        }
      });
      // TODO: 保存処理
      // await OutshotTableService().updateTable(widget.outshotSet);
    }
  }

  // Entry削除ダイアログ
  Future<void> _showDeleteDialog(int index) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.deleteEntry ?? ''),
        content: Text(AppLocalizations.of(context)?.deleteEntryConfirm ?? ''),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (result == true) {
      setState(() {
        widget.outshotSet.combinations.removeAt(index);
      });
      // TODO: 保存処理
      // await OutshotTableService().updateTable(widget.outshotSet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.outshotSet.name)),
      body: Column(
        children: [
          // 検索バー
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)?.searchScoreAndDarts ?? '',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          if (FeatureFlags.enableOutshotDetailSummary) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      AppLocalizations.of(context)?.totalCount ?? '',
                      _filteredCombinations.length.toString(),
                      Icons.list,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard(
                      AppLocalizations.of(context)?.maxScore ?? '',
                      _filteredCombinations.isNotEmpty
                          ? _filteredCombinations
                                .map((c) => c.score)
                                .reduce((a, b) => a > b ? a : b)
                                .toString()
                          : '0',
                      Icons.trending_up,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard(
                      AppLocalizations.of(context)?.minScore ?? '',
                      _filteredCombinations.isNotEmpty
                          ? _filteredCombinations
                                .map((c) => c.score)
                                .reduce((a, b) => a < b ? a : b)
                                .toString()
                          : '0',
                      Icons.trending_down,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
          ],
          // アウトショット一覧
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCombinations.length,
              itemBuilder: (context, index) {
                final combo = _filteredCombinations[index];
                return GestureDetector(
                  onLongPress: () async {
                    // 編集・削除・複製メニュー
                    final action = await showModalBottomSheet<String>(
                      context: context,
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: Text(
                              AppLocalizations.of(context)?.edit ?? '',
                            ),
                            onTap: () => Navigator.pop(context, 'edit'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.copy),
                            title: Text(
                              AppLocalizations.of(context)?.duplicate ?? '',
                            ),
                            onTap: () => Navigator.pop(context, 'duplicate'),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            title: Text(
                              AppLocalizations.of(context)?.delete ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                            onTap: () => Navigator.pop(context, 'delete'),
                          ),
                        ],
                      ),
                    );
                    if (action == 'edit') {
                      _showEntryDialog(entry: combo, editIndex: index);
                    } else if (action == 'duplicate') {
                      setState(() {
                        widget.outshotSet.combinations.add(
                          OutshotEntry(
                            score: combo.score,
                            combination: List<String>.from(combo.combination),
                            description: combo.description,
                          ),
                        );
                      });
                      // TODO: 保存処理
                      // await OutshotTableService().updateTable(widget.outshotSet);
                    } else if (action == 'delete') {
                      _showDeleteDialog(index);
                    }
                  },
                  child: _buildOutshotCard(combo),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEntryDialog(),
        tooltip: AppLocalizations.of(context)?.addEntry ?? '',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildOutshotCard(OutshotEntry combo) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            combo.score.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            if (combo.combination.isNotEmpty) ...[
              for (var target in combo.combination) Chip(label: Text(target)),
            ],
          ],
        ),
        onTap: () {
          if (FeatureFlags.enableOutshotListTileTapAction) {
            _showOutshotDetailDialog(combo);
          }
        },
      ),
    );
  }

  void _showOutshotDetailDialog(OutshotEntry combo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)?.scoreDetail(combo.score) ?? '',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppLocalizations.of(context)?.description ?? ''}: ${combo.description}',
            ),
            const SizedBox(height: 8),
            Text(
              '${AppLocalizations.of(context)?.dartsCount ?? ''}: ${combo.combination.length}本',
            ),
            const SizedBox(height: 8),
            Text(
              '${AppLocalizations.of(context)?.route ?? ''}: ${combo.combination.join(' → ')}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)?.close ?? ''),
          ),
        ],
      ),
    );
  }
}
