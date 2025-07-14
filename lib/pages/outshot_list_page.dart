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

  // 狙いやすい残りを優先するマイアウト用ルート生成
  List<FinishCombination> generateDoubleOutCombinationsForMyOut() {
    // 狙いやすい残り（D16, D20, D8, D12, D10, D18, D6, D4, D14, D2, D1）
    const List<int> easyDoubles = [32, 40, 16, 24, 20, 36, 12, 8, 28, 4, 2];
    final proRoutes = generateDoubleOutCombinations();
    return List.generate(180, (i) {
      final score = i + 1;
      if (score > 170) {
        return FinishCombination(
          score: score,
          dartsNeeded: 0,
          combination: [],
          description: 'ダブルアウト不可',
          isFinishRoute: false,
        );
      }
      // プロルートが存在し、かつ残りがeasyDoublesならそのまま
      final pro = proRoutes[i];
      if (pro.combination.isNotEmpty &&
          easyDoubles.contains(
            int.tryParse(pro.combination.last.replaceAll('D', '')) ?? -1,
          )) {
        return pro.copyWith(description: '狙いやすいダブルアウト', isFinishRoute: true);
      }
      // それ以外は、3投目でeasyDoublesに残すルートを作る
      for (final d in easyDoubles) {
        final remain = score - d;
        if (remain > 0 && remain <= 120) {
          // 2本でremainを作るプロルートを探す
          final twoDartRoute = proRoutes.firstWhere(
            (e) => e.score == remain && e.combination.length == 2,
            orElse: () => FinishCombination(
              score: remain,
              dartsNeeded: 0,
              combination: [],
              description: '',
              isFinishRoute: false,
            ),
          );
          if (twoDartRoute.combination.isNotEmpty) {
            return FinishCombination(
              score: score,
              dartsNeeded: 3,
              combination: [...twoDartRoute.combination, d.toString()],
              description: '狙いやすい残り$dに調整',
              isFinishRoute: false,
            );
          }
        }
      }
      // それもなければプロルート
      return pro.copyWith(isFinishRoute: true);
    });
  }

  // プロモデル用（最短ダブルアウトのみ）
  List<FinishCombination> generateDoubleOutCombinationsForPro() {
    return generateDoubleOutCombinations()
        .map((e) => e.copyWith(isFinishRoute: true))
        .toList();
  }

  // OUTSHOT.mdの表データからダミーデータを生成
  List<FinishCombination> generateOutshotCombinationsFromTable(
    List<List<String>> table,
    int colIndex,
  ) {
    return List.generate(table.length, (i) {
        final row = table[i];
        final score = int.tryParse(row[0]) ?? (i + 1);
        final routeStr = row[colIndex];
        final route = routeStr
            .replaceAll('（即上がり）', '')
            .replaceAll('（残', ',')
            .replaceAll('）', '')
            .replaceAll(' ', '')
            .split(RegExp(r'[→ ]'))
            .where((e) => e.isNotEmpty)
            .toList();
        final last = route.isNotEmpty ? route.last : '';
        final isFinish =
            last.startsWith('D') ||
            last.contains('Bull') ||
            last.contains('D-Bull');
        return FinishCombination(
          score: score,
          dartsNeeded: route.length,
          combination: route,
          description: row[colIndex],
          isFinishRoute: isFinish,
        );
      })
      // 171点以降はダブルアウト不可
      ..addAll(
        List.generate(
          180 - table.length,
          (i) => FinishCombination(
            score: table.length + i + 1,
            dartsNeeded: 0,
            combination: [],
            description: 'ダブルアウト不可',
            isFinishRoute: false,
          ),
        ),
      );
  }

  // OUTSHOT.mdの表データ（1〜180のうち1〜170まで）
  static const List<List<String>> outshotTable = [
    // [数, 初心者, 中級者, 上級者]
    ['170', '20→20→20（残110）', 'T20 T20 Bull（残50）', 'T20 T20 D-Bull（即上がり）'],
    ['169', '', '', ''],
    ['168', '', '', ''],
    ['167', '20→20→20（残107）', 'T20 T19 Bull（残50）', 'T20 T19 D-Bull（即上がり）'],
    ['166', '', '', ''],
    ['165', '', '', ''],
    ['164', '20→20→20（残104）', 'T20 T18 Bull（残50）', 'T20 T18 D-Bull（即上がり）'],
    ['163', '', '', ''],
    ['162', '', '', ''],
    ['161', '20→20→20（残101）', 'T20 T17 Bull（残50）', 'T20 T17 D-Bull（即上がり）'],
    ['160', '20→20→20（残100）', 'T20 T20 D20（即上がり）', 'T20 T20 D20（即上がり）'],
    ['159', '', '', ''],
    ['158', '20→20→18（残100）', 'T20 T20 D19', 'T20 T20 D19'],
    ['157', '20→20→17（残100）', 'T20 T19 D20', 'T20 T19 D20'],
    ['156', '20→20→16（残100）', 'T20 T20 D18', 'T20 T20 D18'],
    ['155', '20→20→15（残100）', 'T20 T19 D19', 'T20 T19 D19'],
    ['154', '20→20→14（残100）', 'T20 T18 D20', 'T20 T18 D20'],
    ['153', '20→20→13（残100）', 'T20 T19 D18', 'T20 T19 D18'],
    ['152', '20→20→12（残100）', 'T20 T20 D16', 'T20 T20 D16'],
    ['151', '20→20→11（残100）', 'T20 T17 D20', 'T20 T17 D20'],
    ['150', '20→20→10（残100）', 'T20 T18 D18', 'T20 T18 D18'],
    ['149', '20→20→9（残100）', 'T20 T19 D16', 'T20 T19 D16'],
    ['148', '20→20→8（残100）', 'T20 T16 D20', 'T20 T16 D20'],
    ['147', '20→20→7（残100）', 'T20 T17 D18', 'T20 T17 D18'],
    ['146', '20→20→6（残100）', 'T20 T18 D16', 'T20 T18 D16'],
    ['145', '20→20→5（残100）', 'T20 T15 D20', 'T20 T15 D20'],
    ['144', '20→20→4（残100）', 'T20 T20 D12', 'T20 T20 D12'],
    ['143', '20→20→3（残100）', 'T20 T17 D16', 'T20 T17 D16'],
    ['142', '20→20→2（残100）', 'T20 T14 D20', 'T20 T14 D20'],
    ['141', '20→20→1（残100）', 'T20 T19 D12', 'T20 T19 D12'],
    ['140', '20→20→20（残80）', 'T20 T20 D10', 'T20 T20 D10'],
    ['139', '20→20→19（残80）', 'T20 T13 D20', 'T20 T13 D20'],
    ['138', '20→20→18（残80）', 'T20 T18 D12', 'T20 T18 D12'],
    ['137', '20→20→17（残80）', 'T20 T19 D10', 'T20 T19 D10'],
    ['136', '20→20→16（残80）', 'T20 T20 D8', 'T20 T20 D8'],
    ['135', '20→20→15（残80）', 'T20 T17 D12', 'T20 T17 D12'],
    ['134', '20→20→14（残80）', 'T20 T14 D16', 'T20 T14 D16'],
    ['133', '20→20→13（残80）', 'T20 T19 D8', 'T20 T19 D8'],
    ['132', '20→20→12（残80）', 'T20 T16 D12', 'T20 T16 D12'],
    ['131', '20→20→11（残80）', 'T20 T13 D16', 'T20 T13 D16'],
    ['130', '20→20→10（残80）', 'T20 T20 D5', 'T20 T20 D5'],
    ['129', '20→20→9（残80）', 'T19 T16 D12', 'T19 T16 D12'],
    ['128', '20→20→8（残80）', 'T18 T14 D16', 'T18 T14 D16'],
    ['127', '20→20→7（残80）', 'T20 T17 D8', 'T20 T17 D8'],
    ['126', '20→20→6（残80）', 'T19 T19 D6', 'T19 T19 D6'],
    ['125', '20→20→5（残80）', 'T20 T15 D10', 'T20 T15 D10'],
    ['124', '20→20→4（残80）', 'T20 T16 D8', 'T20 T16 D8'],
    ['123', '20→20→3（残80）', 'T19 T16 D9', 'T19 T16 D9'],
    ['122', '20→20→2（残80）', 'T18 T18 D7', 'T18 T18 D7'],
    ['121', '20→20→1（残80）', 'T20 T11 D14', 'T20 T11 D14'],
    ['120', '20→20→20（残60）', 'T20 20 D20', 'T20 20 D20'],
    ['119', '20→20→19（残61）', 'T19 20 D20', 'T19 20 D20'],
    ['118', '20→20→18（残62）', 'T20 18 D20', 'T20 18 D20'],
    ['117', '20→20→17（残63）', 'T20 17 D20', 'T20 17 D20'],
    ['116', '20→20→16（残64）', 'T20 16 D20', 'T20 16 D20'],
    ['115', '20→20→15（残65）', 'T20 15 D20', 'T20 15 D20'],
    ['114', '20→20→14（残66）', 'T20 14 D20', 'T20 14 D20'],
    ['113', '20→20→13（残67）', 'T20 13 D20', 'T20 13 D20'],
    ['112', '20→20→12（残68）', 'T20 12 D20', 'T20 12 D20'],
    ['111', '20→20→11（残69）', 'T20 11 D20', 'T20 11 D20'],
    ['110', '20→20→10（残70）', 'T20 10 D20', 'T20 10 D20'],
    ['109', '20→20→9（残71）', 'T20 9 D20', 'T20 9 D20'],
    ['108', '20→20→8（残72）', 'T20 8 D20', 'T20 8 D20'],
    ['107', '20→20→7（残73）', 'T19 10 D20', 'T19 10 D20'],
    ['106', '20→20→6（残74）', 'T20 6 D20', 'T20 6 D20'],
    ['105', '20→20→5（残75）', 'T20 5 D20', 'T20 5 D20'],
    ['104', '20→20→4（残76）', 'T18 18 D16', 'T18 18 D16'],
    ['103', '20→20→3（残77）', 'T17 12 D20', 'T17 12 D20'],
    ['102', '20→20→2（残78）', 'T20 10 D16', 'T20 10 D16'],
    ['101', '20→20→1（残79）', 'T17 10 D20', 'T17 10 D20'],
    ['100', '20→20→20（残40）', 'T20 D20', 'T20 D20'],
    ['99', '20→19→20（残40）', 'T19 10 D16', 'T19 10 D16'],
    ['98', '20→18→20（残40）', 'T20 D19', 'T20 D19'],
    ['97', '20→17→20（残40）', 'T19 D20', 'T19 D20'],
    ['96', '20→16→20（残40）', 'T20 D18', 'T20 D18'],
    ['95', '20→15→20（残40）', 'T19 D19', 'T19 D19'],
    ['94', '20→14→20（残40）', 'T18 D20', 'T18 D20'],
    ['93', '20→13→20（残40）', 'T19 D18', 'T19 D18'],
    ['92', '20→12→20（残40）', 'T20 D16', 'T20 D16'],
    ['91', '20→11→20（残40）', 'T17 D20', 'T17 D20'],
    ['90', '20→10→20（残40）', 'T18 D18', 'T18 D18'],
    ['89', '20→9→20（残40）', 'T19 D16', 'T19 D16'],
    ['88', '20→8→20（残40）', 'T16 D20', 'T16 D20'],
    ['87', '20→7→20（残40）', 'T17 D18', 'T17 D18'],
    ['86', '20→6→20（残40）', 'T18 D16', 'T18 D16'],
    ['85', '20→5→20（残40）', 'T15 D20', 'T15 D20'],
    ['84', '20→4→20（残40）', 'T20 D12', 'T20 D12'],
    ['83', '20→3→20（残40）', 'T17 D16', 'T17 D16'],
    ['82', '20→2→20（残40）', 'Bull D16', 'Bull D16'],
    ['81', '20→1→20（残40）', 'T19 D12', 'T19 D12'],
    ['80', '20→20→20（残20）', 'T20 D10', 'T20 D10'],
    ['79', '19→20→20（残20）', 'T13 D20', 'T13 D20'],
    ['78', '18→20→20（残20）', 'T18 D12', 'T18 D12'],
    ['77', '17→20→20（残20）', 'T19 D10', 'T19 D10'],
    ['76', '16→20→20（残20）', 'T20 D8', 'T20 D8'],
    ['75', '15→20→20（残20）', 'T17 D12', 'T17 D12'],
    ['74', '14→20→20（残20）', 'T14 D16', 'T14 D16'],
    ['73', '13→20→20（残20）', 'T19 D8', 'T19 D8'],
    ['72', '12→20→20（残20）', 'T16 D12', 'T16 D12'],
    ['71', '11→20→20（残20）', 'T13 D16', 'T13 D16'],
    ['70', '10→20→20（残20）', 'T18 D8', 'T18 D8'],
    ['69', '9→20→20（残20）', 'T19 D6', 'T19 D6'],
    ['68', '8→20→20（残20）', 'T20 D4', 'T20 D4'],
    ['67', '7→20→20（残20）', 'T17 D8', 'T17 D8'],
    ['66', '6→20→20（残20）', 'T10 D18', 'T10 D18'],
    ['65', '5→20→20（残20）', 'T19 D4', 'T19 D4'],
    ['64', '4→20→20（残20）', 'T16 D8', 'T16 D8'],
    ['63', '3→20→20（残20）', 'T13 D12', 'T13 D12'],
    ['62', '2→20→20（残20）', 'T10 D16', 'T10 D16'],
    ['61', '1→20→20（残20）', 'T15 D8', 'T15 D8'],
    ['60', '20→20（残20）', '20 D20', '20 D20'],
    ['59', '19→20（残20）', '19 D20', '19 D20'],
    ['58', '18→20（残20）', '18 D20', '18 D20'],
    ['57', '17→20（残20）', '17 D20', '17 D20'],
    ['56', '16→20（残20）', '16 D20', '16 D20'],
    ['55', '15→20（残20）', '15 D20', '15 D20'],
    ['54', '14→20（残20）', '14 D20', '14 D20'],
    ['53', '13→20（残20）', '13 D20', '13 D20'],
    ['52', '12→20（残20）', '12 D20', '12 D20'],
    ['51', '11→20（残20）', '11 D20', '11 D20'],
    ['50', '10→20（残20）', '10 D20', '10 D20'],
    ['49', '9→20（残20）', '9 D20', '9 D20'],
    ['48', '8→20（残20）', '16 D16', '16 D16'],
    ['47', '7→20（残20）', '15 D16', '15 D16'],
    ['46', '6→20（残20）', '14 D16', '14 D16'],
    ['45', '5→20（残20）', '13 D16', '13 D16'],
    ['44', '4→20（残20）', '12 D16', '12 D16'],
    ['43', '3→20（残20）', '11 D16', '11 D16'],
    ['42', '2→20（残20）', '10 D16', '10 D16'],
    ['41', '1→20（残20）', '9 D16', '9 D16'],
    ['40', 'D20', 'D20', 'D20'],
    ['39', '7→D16', '7 D16', '7 D16'],
    ['38', '6→D16', '6 D16', '6 D16'],
    ['37', '5→D16', '5 D16', '5 D16'],
    ['36', '4→D16', '4 D16', '4 D16'],
    ['35', '3→D16', '3 D16', '3 D16'],
    ['34', '2→D16', '2 D16', '2 D16'],
    ['33', '1→D16', '1 D16', '1 D16'],
    ['32', 'D16', 'D16', 'D16'],
    ['31', '7→D12', '7 D12', '7 D12'],
    ['30', '6→D12', '6 D12', '6 D12'],
    ['29', '5→D12', '5 D12', '5 D12'],
    ['28', '4→D12', '4 D12', '4 D12'],
    ['27', '3→D12', '3 D12', '3 D12'],
    ['26', '2→D12', '2 D12', '2 D12'],
    ['25', '1→D12', '1 D12', '1 D12'],
    ['24', 'D12', 'D12', 'D12'],
    ['23', '7→D8', '7 D8', '7 D8'],
    ['22', '6→D8', '6 D8', '6 D8'],
    ['21', '5→D8', '5 D8', '5 D8'],
    ['20', 'D10', 'D10', 'D10'],
    ['19', '7→D6', '7 D6', '7 D6'],
    ['18', 'D9', 'D9', 'D9'],
    ['17', '9→D4', '9 D4', '9 D4'],
    ['16', 'D8', 'D8', 'D8'],
    ['15', '7→D4', '7 D4', '7 D4'],
    ['14', 'D7', 'D7', 'D7'],
    ['13', '5→D4', '5 D4', '5 D4'],
    ['12', 'D6', 'D6', 'D6'],
    ['11', '3→D4', '3 D4', '3 D4'],
    ['10', 'D5', 'D5', 'D5'],
    ['9', '1→D4', '1 D4', '1 D4'],
    ['8', 'D4', 'D4', 'D4'],
    ['7', '3→D2', '3 D2', '3 D2'],
    ['6', 'D3', 'D3', 'D3'],
    ['5', '1→D2', '1 D2', '1 D2'],
    ['4', 'D2', 'D2', 'D2'],
    ['3', '1→D1', '1 D1', '1 D1'],
    ['2', 'D1', 'D1', 'D1'],
  ];

  // 仮データ
  List<OutshotSet> get dummySets => [
    OutshotSet(
      id: '1',
      name: 'マイアウトショット',
      combinations: generateOutshotCombinationsFromTable(
        outshotTable,
        2,
      ), // 中級者
      createdAt: DateTime.now(),
    ),
    OutshotSet(
      id: '2',
      name: 'プロモデル',
      combinations: generateOutshotCombinationsFromTable(
        outshotTable,
        3,
      ), // 上級者
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
