import '../models/finish_combination.dart';

class DartsCalculator {
  static final Map<int, FinishCombination> _defaultFinishes = {
    1: const FinishCombination(score: 1, dartsNeeded: 1, combination: ['S1'], description: 'シングル1'),
    2: const FinishCombination(score: 2, dartsNeeded: 1, combination: ['D1'], description: 'ダブル1'),
    3: const FinishCombination(score: 3, dartsNeeded: 1, combination: ['S3'], description: 'シングル3'),
    4: const FinishCombination(score: 4, dartsNeeded: 1, combination: ['D2'], description: 'ダブル2'),
    5: const FinishCombination(score: 5, dartsNeeded: 1, combination: ['S5'], description: 'シングル5'),
    6: const FinishCombination(score: 6, dartsNeeded: 1, combination: ['D3'], description: 'ダブル3'),
    7: const FinishCombination(score: 7, dartsNeeded: 1, combination: ['S7'], description: 'シングル7'),
    8: const FinishCombination(score: 8, dartsNeeded: 1, combination: ['D4'], description: 'ダブル4'),
    9: const FinishCombination(score: 9, dartsNeeded: 2, combination: ['S1', 'D4'], description: 'シングル1, ダブル4'),
    10: const FinishCombination(score: 10, dartsNeeded: 1, combination: ['D5'], description: 'ダブル5'),
    11: const FinishCombination(score: 11, dartsNeeded: 2, combination: ['S1', 'D5'], description: 'シングル1, ダブル5'),
    12: const FinishCombination(score: 12, dartsNeeded: 1, combination: ['D6'], description: 'ダブル6'),
    13: const FinishCombination(score: 13, dartsNeeded: 2, combination: ['S3', 'D5'], description: 'シングル3, ダブル5'),
    14: const FinishCombination(score: 14, dartsNeeded: 1, combination: ['D7'], description: 'ダブル7'),
    15: const FinishCombination(score: 15, dartsNeeded: 2, combination: ['S5', 'D5'], description: 'シングル5, ダブル5'),
    16: const FinishCombination(score: 16, dartsNeeded: 1, combination: ['D8'], description: 'ダブル8'),
    17: const FinishCombination(score: 17, dartsNeeded: 2, combination: ['S7', 'D5'], description: 'シングル7, ダブル5'),
    18: const FinishCombination(score: 18, dartsNeeded: 1, combination: ['D9'], description: 'ダブル9'),
    19: const FinishCombination(score: 19, dartsNeeded: 2, combination: ['S3', 'D8'], description: 'シングル3, ダブル8'),
    20: const FinishCombination(score: 20, dartsNeeded: 1, combination: ['D10'], description: 'ダブル10'),
    21: const FinishCombination(score: 21, dartsNeeded: 2, combination: ['S5', 'D8'], description: 'シングル5, ダブル8'),
    22: const FinishCombination(score: 22, dartsNeeded: 1, combination: ['D11'], description: 'ダブル11'),
    23: const FinishCombination(score: 23, dartsNeeded: 2, combination: ['S7', 'D8'], description: 'シングル7, ダブル8'),
    24: const FinishCombination(score: 24, dartsNeeded: 1, combination: ['D12'], description: 'ダブル12'),
    25: const FinishCombination(score: 25, dartsNeeded: 2, combination: ['S9', 'D8'], description: 'シングル9, ダブル8'),
    26: const FinishCombination(score: 26, dartsNeeded: 1, combination: ['D13'], description: 'ダブル13'),
    27: const FinishCombination(score: 27, dartsNeeded: 2, combination: ['S11', 'D8'], description: 'シングル11, ダブル8'),
    28: const FinishCombination(score: 28, dartsNeeded: 1, combination: ['D14'], description: 'ダブル14'),
    29: const FinishCombination(score: 29, dartsNeeded: 2, combination: ['S13', 'D8'], description: 'シングル13, ダブル8'),
    30: const FinishCombination(score: 30, dartsNeeded: 1, combination: ['D15'], description: 'ダブル15'),
    32: const FinishCombination(score: 32, dartsNeeded: 1, combination: ['D16'], description: 'ダブル16'),
    34: const FinishCombination(score: 34, dartsNeeded: 1, combination: ['D17'], description: 'ダブル17'),
    36: const FinishCombination(score: 36, dartsNeeded: 1, combination: ['D18'], description: 'ダブル18'),
    38: const FinishCombination(score: 38, dartsNeeded: 1, combination: ['D19'], description: 'ダブル19'),
    40: const FinishCombination(score: 40, dartsNeeded: 1, combination: ['D20'], description: 'ダブル20'),
    41: const FinishCombination(score: 41, dartsNeeded: 2, combination: ['S1', 'D20'], description: 'シングル1, ダブル20'),
    42: const FinishCombination(score: 42, dartsNeeded: 2, combination: ['S10', 'D16'], description: 'シングル10, ダブル16'),
    43: const FinishCombination(score: 43, dartsNeeded: 2, combination: ['S3', 'D20'], description: 'シングル3, ダブル20'),
    44: const FinishCombination(score: 44, dartsNeeded: 2, combination: ['S12', 'D16'], description: 'シングル12, ダブル16'),
    45: const FinishCombination(score: 45, dartsNeeded: 2, combination: ['S5', 'D20'], description: 'シングル5, ダブル20'),
    46: const FinishCombination(score: 46, dartsNeeded: 2, combination: ['S14', 'D16'], description: 'シングル14, ダブル16'),
    47: const FinishCombination(score: 47, dartsNeeded: 2, combination: ['S7', 'D20'], description: 'シングル7, ダブル20'),
    48: const FinishCombination(score: 48, dartsNeeded: 2, combination: ['S16', 'D16'], description: 'シングル16, ダブル16'),
    49: const FinishCombination(score: 49, dartsNeeded: 2, combination: ['S9', 'D20'], description: 'シングル9, ダブル20'),
    50: const FinishCombination(score: 50, dartsNeeded: 2, combination: ['S10', 'D20'], description: 'シングル10, ダブル20'),
    51: const FinishCombination(score: 51, dartsNeeded: 2, combination: ['S11', 'D20'], description: 'シングル11, ダブル20'),
    52: const FinishCombination(score: 52, dartsNeeded: 2, combination: ['S12', 'D20'], description: 'シングル12, ダブル20'),
    53: const FinishCombination(score: 53, dartsNeeded: 2, combination: ['S13', 'D20'], description: 'シングル13, ダブル20'),
    54: const FinishCombination(score: 54, dartsNeeded: 2, combination: ['S14', 'D20'], description: 'シングル14, ダブル20'),
    55: const FinishCombination(score: 55, dartsNeeded: 2, combination: ['S15', 'D20'], description: 'シングル15, ダブル20'),
    56: const FinishCombination(score: 56, dartsNeeded: 2, combination: ['S16', 'D20'], description: 'シングル16, ダブル20'),
    57: const FinishCombination(score: 57, dartsNeeded: 2, combination: ['S17', 'D20'], description: 'シングル17, ダブル20'),
    58: const FinishCombination(score: 58, dartsNeeded: 2, combination: ['S18', 'D20'], description: 'シングル18, ダブル20'),
    59: const FinishCombination(score: 59, dartsNeeded: 2, combination: ['S19', 'D20'], description: 'シングル19, ダブル20'),
    60: const FinishCombination(score: 60, dartsNeeded: 2, combination: ['S20', 'D20'], description: 'シングル20, ダブル20'),
    61: const FinishCombination(score: 61, dartsNeeded: 3, combination: ['S15', 'S6', 'D20'], description: 'シングル15, シングル6, ダブル20'),
    62: const FinishCombination(score: 62, dartsNeeded: 3, combination: ['S16', 'S6', 'D20'], description: 'シングル16, シングル6, ダブル20'),
    63: const FinishCombination(score: 63, dartsNeeded: 3, combination: ['S17', 'S6', 'D20'], description: 'シングル17, シングル6, ダブル20'),
    64: const FinishCombination(score: 64, dartsNeeded: 3, combination: ['T16', 'D8'], description: 'トリプル16, ダブル8'),
    65: const FinishCombination(score: 65, dartsNeeded: 3, combination: ['T15', 'D10'], description: 'トリプル15, ダブル10'),
    66: const FinishCombination(score: 66, dartsNeeded: 3, combination: ['T14', 'D12'], description: 'トリプル14, ダブル12'),
    67: const FinishCombination(score: 67, dartsNeeded: 3, combination: ['T13', 'D14'], description: 'トリプル13, ダブル14'),
    68: const FinishCombination(score: 68, dartsNeeded: 3, combination: ['T12', 'D16'], description: 'トリプル12, ダブル16'),
    69: const FinishCombination(score: 69, dartsNeeded: 3, combination: ['T11', 'D18'], description: 'トリプル11, ダブル18'),
    70: const FinishCombination(score: 70, dartsNeeded: 3, combination: ['T10', 'D20'], description: 'トリプル10, ダブル20'),
    100: const FinishCombination(score: 100, dartsNeeded: 3, combination: ['T20', 'D20'], description: 'トリプル20, ダブル20'),
    101: const FinishCombination(score: 101, dartsNeeded: 3, combination: ['T17', 'D25'], description: 'トリプル17, ダブル25'),
    110: const FinishCombination(score: 110, dartsNeeded: 3, combination: ['T20', 'Bull'], description: 'トリプル20, ブル'),
    120: const FinishCombination(score: 120, dartsNeeded: 3, combination: ['T20', 'T20'], description: 'トリプル20, トリプル20'),
    141: const FinishCombination(score: 141, dartsNeeded: 3, combination: ['T20', 'T19', 'D12'], description: 'トリプル20, トリプル19, ダブル12'),
    150: const FinishCombination(score: 150, dartsNeeded: 3, combination: ['T20', 'T18', 'D18'], description: 'トリプル20, トリプル18, ダブル18'),
    160: const FinishCombination(score: 160, dartsNeeded: 3, combination: ['T20', 'T20', 'D20'], description: 'トリプル20, トリプル20, ダブル20'),
    170: const FinishCombination(score: 170, dartsNeeded: 3, combination: ['T20', 'T20', 'Bull'], description: 'トリプル20, トリプル20, ブル'),
    180: const FinishCombination(score: 180, dartsNeeded: 3, combination: ['T20', 'T20', 'T20'], description: 'トリプル20, トリプル20, トリプル20'),
  };

  static Map<int, FinishCombination> getDefaultFinishes() {
    return Map.from(_defaultFinishes);
  }

  static List<FinishCombination> getSuggestedFinishes(int score, {int maxDarts = 3}) {
    final suggestions = <FinishCombination>[];
    
    // 基本的なフィニッシュ
    if (_defaultFinishes.containsKey(score)) {
      suggestions.add(_defaultFinishes[score]!);
    }
    
    // 追加の提案を生成
    if (score <= 40 && score % 2 == 0) {
      suggestions.add(FinishCombination(
        score: score,
        dartsNeeded: 1,
        combination: ['D${score ~/ 2}'],
        description: 'ダブル${score ~/ 2}',
      ));
    }
    
    // 2ダーツでのフィニッシュ
    if (score <= 100 && score > 40) {
      for (int i = 1; i <= 20; i++) {
        int remaining = score - i;
        if (remaining > 0 && remaining <= 40 && remaining % 2 == 0) {
          suggestions.add(FinishCombination(
            score: score,
            dartsNeeded: 2,
            combination: ['S$i', 'D${remaining ~/ 2}'],
            description: 'シングル$i, ダブル${remaining ~/ 2}',
          ));
        }
      }
    }
    
    return suggestions;
  }

  static bool isValidFinish(int score) {
    return score > 0 && score <= 180;
  }

  static bool canFinishWithDoubles(int score) {
    return score > 0 && score <= 40 && score % 2 == 0;
  }

  static int calculateRemainingScore(int currentScore, int thrownScore) {
    final remaining = currentScore - thrownScore;
    return remaining < 0 ? currentScore : remaining;
  }

  static bool isBustScore(int currentScore, int thrownScore) {
    final remaining = currentScore - thrownScore;
    return remaining < 0 || remaining == 1;
  }

  static List<String> getCommonCheckouts() {
    return [
      'D20 (40)',
      'D16 (32)',
      'D12 (24)',
      'D10 (20)',
      'D8 (16)',
      'T20, D20 (100)',
      'T20, T20, D20 (160)',
      'T20, T20, Bull (170)',
    ];
  }

  static String formatThrow(String throwStr) {
    if (throwStr.startsWith('S')) {
      return throwStr.substring(1);
    } else if (throwStr.startsWith('D')) {
      return 'D${throwStr.substring(1)}';
    } else if (throwStr.startsWith('T')) {
      return 'T${throwStr.substring(1)}';
    } else if (throwStr == 'Bull') {
      return 'Bull';
    }
    return throwStr;
  }
}