import 'package:flutter/material.dart';
import 'package:outshotx/models/outshot_label.dart';
import 'package:outshotx/services/label_service.dart';

import '../constants/double_out_routes.dart';
import '../models/outshot.dart';
import '../models/outshot_set.dart';
import 'outshot_detail_page.dart';

class OutshotListPage extends StatefulWidget {
  const OutshotListPage({super.key});

  @override
  State<OutshotListPage> createState() => _OutshotListPageState();
}

class _OutshotListPageState extends State<OutshotListPage> {
  final LabelService _labelService = LabelService();
  List<OutshotLabel> _allLabels = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLabels();
  }

  Future<void> _loadLabels() async {
    try {
      final labels = await _labelService.getAllLabels();
      setState(() {
        _allLabels = labels;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ダブルアウトのアウトショットを生成
  List<OutShot> generateDoubleOutCombinations() {
    return DoubleOutRoutes.routes.entries
        .map(
          (entry) => OutShot(
            score: entry.key,
            combination: entry.value,
            description: 'ダブルアウトルート',
          ),
        )
        .toList();
  }

  // 仮データ
  List<OutshotSet> get dummySets => [
    OutshotSet(
      id: '1',
      name: 'サンプルセット',
      labelIds: ['double_out', 'hard'],
      combinations: generateDoubleOutCombinations(),
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
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ラベル
                      if (set.labelIds.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: Wrap(
                            spacing: 4,
                            runSpacing: 2,
                            alignment: WrapAlignment.start,
                            children: set.labelIds.map((labelId) {
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
                                  color: Colors.blue.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.blue.withValues(alpha: 0.3),
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
                        '作成日: ${set.createdAt.toLocal().toString().split(" ")[0]}',
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
