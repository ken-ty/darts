import 'package:flutter/material.dart';

import '../models/finish_combination.dart';
import '../models/outshot_set.dart';
import 'outshot_detail_page.dart'; // 後で作成

class OutshotListPage extends StatelessWidget {
  const OutshotListPage({super.key});

  // 仮データ
  List<OutshotSet> get dummySets => [
    OutshotSet(
      id: '1',
      name: 'マイアウトショット',
      combinations: List.generate(
        180,
        (i) => FinishCombination(
          score: i + 1,
          dartsNeeded: 3,
          combination: ['T20', 'T20', 'D20'],
          description: '例: 3本でフィニッシュ',
        ),
      ),
      createdAt: DateTime.now(),
    ),
    OutshotSet(
      id: '2',
      name: 'プロモデル',
      combinations: List.generate(
        180,
        (i) => FinishCombination(
          score: i + 1,
          dartsNeeded: 2,
          combination: ['T19', 'D12'],
          description: '例: プロの推奨ルート',
        ),
      ),
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    // TODO: 新規作成ダイアログ
                  },
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
            child: ListView.separated(
              itemCount: dummySets.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final set = dummySets[index];
                return ListTile(
                  title: Text(set.name),
                  subtitle: Text(
                    '作成日: ${set.createdAt.toLocal().toString().split(" ")[0]}',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OutshotDetailPage(outshotSet: set),
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
