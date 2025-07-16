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

    return combinations;
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
                      '総数',
                      _filteredCombinations.length.toString(),
                      Icons.list,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard(
                      '最大スコア',
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
                      '最小スコア',
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
                return _buildOutshotCard(combo);
              },
            ),
          ),
        ],
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
        onTap: () => _showOutshotDetailDialog(combo),
      ),
    );
  }

  void _showOutshotDetailDialog(OutshotEntry combo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${combo.score}点の詳細'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('説明: ${combo.description}'),
            const SizedBox(height: 8),
            Text('ダーツ数: ${combo.combination.length}本'),
            const SizedBox(height: 8),
            Text('ルート: ${combo.combination.join(' → ')}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }
}
