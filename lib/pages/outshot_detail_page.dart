import 'package:flutter/material.dart';

import '../models/finish_combination.dart';
import '../models/outshot_set.dart';

class OutshotDetailPage extends StatefulWidget {
  final OutshotSet outshotSet;

  const OutshotDetailPage({super.key, required this.outshotSet});

  @override
  State<OutshotDetailPage> createState() => _OutshotDetailPageState();
}

class _OutshotDetailPageState extends State<OutshotDetailPage> {
  String _searchQuery = '';
  String _filterType = 'all'; // 'all', 'finish', 'non-finish'

  List<FinishCombination> get _filteredCombinations {
    var combinations = widget.outshotSet.combinations;

    // 検索フィルタリング
    if (_searchQuery.isNotEmpty) {
      combinations = combinations.where((combo) {
        return combo.score.toString().contains(_searchQuery) ||
            combo.description.contains(_searchQuery) ||
            combo.combination.any((dart) => dart.contains(_searchQuery));
      }).toList();
    }

    // タイプフィルタリング
    switch (_filterType) {
      case 'finish':
        combinations = combinations
            .where((combo) => combo.isFinishRoute)
            .toList();
        break;
      case 'non-finish':
        combinations = combinations
            .where((combo) => !combo.isFinishRoute)
            .toList();
        break;
      default:
        // 'all' の場合は何もしない
        break;
    }

    return combinations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.outshotSet.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 検索機能の実装
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _filterType = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'all', child: Text('全て表示')),
              const PopupMenuItem(value: 'finish', child: Text('フィニッシュルートのみ')),
              const PopupMenuItem(value: 'non-finish', child: Text('調整ルートのみ')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // 検索バー
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'スコアやダーツを検索...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // 統計情報
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
                    'フィニッシュ',
                    _filteredCombinations
                        .where((c) => c.isFinishRoute)
                        .length
                        .toString(),
                    Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard(
                    '調整',
                    _filteredCombinations
                        .where((c) => !c.isFinishRoute)
                        .length
                        .toString(),
                    Icons.tune,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
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

  Widget _buildOutshotCard(FinishCombination combo) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: combo.isFinishRoute ? Colors.green : Colors.orange,
          child: Text(
            combo.score.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          '${combo.score}点',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(combo.description),
            if (combo.combination.isNotEmpty)
              Text(
                combo.combination.join(' → '),
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (combo.isFinishRoute)
              const Icon(Icons.check_circle, color: Colors.green)
            else
              const Icon(Icons.tune, color: Colors.orange),
            const SizedBox(width: 8),
            Text('${combo.dartsNeeded}本'),
          ],
        ),
        onTap: () {
          // TODO: 詳細表示や編集機能
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('${combo.score}点の詳細を表示')));
        },
      ),
    );
  }
}
