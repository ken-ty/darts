import 'package:flutter/material.dart';

import '../models/outshot_set.dart';

class OutshotDetailPage extends StatelessWidget {
  final OutshotSet outshotSet;
  const OutshotDetailPage({super.key, required this.outshotSet});

  @override
  Widget build(BuildContext context) {
    Color getBgColor(bool isFinish) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      if (isFinish) {
        return isDark
            ? const Color(0xFF26C6DA)
            : const Color(0xFFB2F2E5); // エメラルド/ミント
      } else {
        return isDark
            ? const Color(0xFF37474F)
            : const Color(0xFFE3F2FD); // ブルーグレー
      }
    }

    Color getTextColor(bool isFinish) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      if (isFinish) {
        return isDark ? Colors.white : Colors.black;
      } else {
        return isDark ? Colors.white : Colors.black;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(outshotSet.name)),
      body: ListView.separated(
        itemCount: outshotSet.combinations.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final finish = outshotSet.combinations[index];
          return Container(
            color: getBgColor(finish.isFinishRoute),
            child: ListTile(
              title: Text(
                '${finish.score}点',
                style: TextStyle(color: getTextColor(finish.isFinishRoute)),
              ),
              subtitle: Text(
                finish.combination.join(' → '),
                style: TextStyle(color: getTextColor(finish.isFinishRoute)),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: getBgColor(finish.isFinishRoute),
                    title: Text(
                      '${finish.score}点のアウトショット',
                      style: TextStyle(
                        color: getTextColor(finish.isFinishRoute),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '必要ダーツ数: ${finish.dartsNeeded}',
                          style: TextStyle(
                            color: getTextColor(finish.isFinishRoute),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'ルート: ${finish.combination.join(' → ')}',
                          style: TextStyle(
                            color: getTextColor(finish.isFinishRoute),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '説明: ${finish.description}',
                          style: TextStyle(
                            color: getTextColor(finish.isFinishRoute),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('閉じる'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
