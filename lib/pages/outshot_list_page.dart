import 'package:flutter/material.dart';

import '../models/finish_combination.dart';
import '../models/outshot_set.dart';
import 'outshot_detail_page.dart'; // 後で作成

class OutshotListPage extends StatelessWidget {
  const OutshotListPage({super.key});

  // ダブルアウトのアウトショット（1〜180）を生成
  List<FinishCombination> generateDoubleOutCombinations() {
    // 有名なダブルアウト表（例: https://www.mastercaller.com/darts/checkouts）
    // ここでは一部のみ例示、実際は全て埋めるのが理想
    final Map<int, List<String>> doubleOutRoutes = {
      170: ['T20', 'T20', 'D25'],
      167: ['T20', 'T19', 'D25'],
      164: ['T20', 'T18', 'D25'],
      161: ['T20', 'T17', 'D25'],
      160: ['T20', 'T20', 'D20'],
      158: ['T20', 'T20', 'D19'],
      157: ['T20', 'T19', 'D20'],
      156: ['T20', 'T20', 'D18'],
      155: ['T20', 'T19', 'D19'],
      154: ['T20', 'T18', 'D20'],
      153: ['T20', 'T19', 'D18'],
      152: ['T20', 'T20', 'D16'],
      151: ['T20', 'T17', 'D20'],
      150: ['T20', 'T18', 'D18'],
      149: ['T20', 'T19', 'D16'],
      148: ['T20', 'T16', 'D20'],
      147: ['T20', 'T17', 'D18'],
      146: ['T20', 'T18', 'D16'],
      145: ['T20', 'T15', 'D20'],
      144: ['T20', 'T20', 'D12'],
      143: ['T20', 'T17', 'D16'],
      142: ['T20', 'T14', 'D20'],
      141: ['T20', 'T19', 'D12'],
      140: ['T20', 'T16', 'D16'],
      139: ['T19', 'T14', 'D20'],
      138: ['T20', 'T18', 'D12'],
      137: ['T20', 'T19', 'D10'],
      136: ['T20', 'T20', 'D8'],
      135: ['T20', 'T17', 'D12'],
      134: ['T20', 'T14', 'D16'],
      133: ['T20', 'T19', 'D8'],
      132: ['T20', 'T16', 'D12'],
      131: ['T20', 'T13', 'D16'],
      130: ['T20', 'T18', 'D8'],
      129: ['T19', 'T16', 'D12'],
      128: ['T18', 'T14', 'D16'],
      127: ['T20', 'T17', 'D8'],
      126: ['T19', 'T19', 'D6'],
      125: ['25', 'T20', 'D20'],
      124: ['T20', 'T16', 'D8'],
      123: ['T19', 'T16', 'D9'],
      122: ['T18', 'T20', 'D4'],
      121: ['T20', 'T11', 'D14'],
      120: ['T20', '20', 'D20'],
      119: ['T19', 'T10', 'D16'],
      118: ['T20', '18', 'D20'],
      117: ['T20', '17', 'D20'],
      116: ['T20', '16', 'D20'],
      115: ['T20', '15', 'D20'],
      114: ['T20', '14', 'D20'],
      113: ['T20', '13', 'D20'],
      112: ['T20', '12', 'D20'],
      111: ['T20', '11', 'D20'],
      110: ['T20', '10', 'D20'],
      109: ['T20', '9', 'D20'],
      108: ['T20', '8', 'D20'],
      107: ['T19', '10', 'D20'],
      106: ['T20', '6', 'D20'],
      105: ['T19', '8', 'D20'],
      104: ['T18', '18', 'D16'],
      103: ['T17', '12', 'D20'],
      102: ['T20', '10', 'D16'],
      101: ['T17', '10', 'D20'],
      100: ['T20', 'D20'],
      99: ['T19', '10', 'D16'],
      98: ['T20', 'D19'],
      97: ['T19', 'D20'],
      96: ['T20', 'D18'],
      95: ['T19', 'D19'],
      94: ['T18', 'D20'],
      93: ['T19', 'D18'],
      92: ['T20', 'D16'],
      91: ['T17', 'D20'],
      90: ['T18', 'D18'],
      89: ['T19', 'D16'],
      88: ['T16', 'D20'],
      87: ['T17', 'D18'],
      86: ['T18', 'D16'],
      85: ['T15', 'D20'],
      84: ['T20', 'D12'],
      83: ['T17', 'D16'],
      82: ['BULL', 'D16'],
      81: ['T19', 'D12'],
      80: ['T20', 'D10'],
      79: ['T13', 'D20'],
      78: ['T18', 'D12'],
      77: ['T19', 'D10'],
      76: ['T20', 'D8'],
      75: ['T17', 'D12'],
      74: ['T14', 'D16'],
      73: ['T19', 'D8'],
      72: ['T16', 'D12'],
      71: ['T13', 'D16'],
      70: ['T18', 'D8'],
      69: ['T19', 'D6'],
      68: ['T20', 'D4'],
      67: ['T17', 'D8'],
      66: ['T10', 'D18'],
      65: ['T19', 'D4'],
      64: ['T16', 'D8'],
      63: ['T13', 'D12'],
      62: ['T10', 'D16'],
      61: ['T15', 'D8'],
      60: ['20', 'D20'],
      59: ['19', 'D20'],
      58: ['18', 'D20'],
      57: ['17', 'D20'],
      56: ['16', 'D20'],
      55: ['15', 'D20'],
      54: ['14', 'D20'],
      53: ['13', 'D20'],
      52: ['12', 'D20'],
      51: ['11', 'D20'],
      50: ['10', 'D20'],
      49: ['9', 'D20'],
      48: ['16', 'D16'],
      47: ['15', 'D16'],
      46: ['14', 'D16'],
      45: ['13', 'D16'],
      44: ['12', 'D16'],
      43: ['11', 'D16'],
      42: ['10', 'D16'],
      41: ['9', 'D16'],
      40: ['D20'],
      39: ['7', 'D16'],
      38: ['D19'],
      37: ['5', 'D16'],
      36: ['D18'],
      35: ['3', 'D16'],
      34: ['D17'],
      33: ['1', 'D16'],
      32: ['D16'],
      31: ['15', 'D8'],
      30: ['D15'],
      29: ['13', 'D8'],
      28: ['D14'],
      27: ['11', 'D8'],
      26: ['D13'],
      25: ['9', 'D8'],
      24: ['D12'],
      23: ['7', 'D8'],
      22: ['D11'],
      21: ['5', 'D8'],
      20: ['D10'],
      19: ['3', 'D8'],
      18: ['D9'],
      17: ['1', 'D8'],
      16: ['D8'],
      15: ['7', 'D4'],
      14: ['D7'],
      13: ['5', 'D4'],
      12: ['D6'],
      11: ['3', 'D4'],
      10: ['D5'],
      9: ['1', 'D4'],
      8: ['D4'],
      7: ['3', 'D2'],
      6: ['D3'],
      5: ['1', 'D2'],
      4: ['D2'],
      3: ['1', 'D1'],
      2: ['D1'],
    };

    return List.generate(180, (i) {
      final score = i + 1;
      if (score > 170) {
        return FinishCombination(
          score: score,
          dartsNeeded: 0,
          combination: [],
          description: 'ダブルアウト不可',
        );
      }
      final route = doubleOutRoutes[score];
      if (route != null) {
        return FinishCombination(
          score: score,
          dartsNeeded: route.length,
          combination: route,
          description: 'ダブルアウトルート',
        );
      } else {
        return FinishCombination(
          score: score,
          dartsNeeded: 0,
          combination: [],
          description: 'ダブルアウト不可',
        );
      }
    });
  }

  // 仮データ
  List<OutshotSet> get dummySets => [
    OutshotSet(
      id: '1',
      name: 'マイアウトショット',
      combinations: generateDoubleOutCombinations(),
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
