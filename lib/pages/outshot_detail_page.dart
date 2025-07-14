import 'package:flutter/material.dart';

import '../models/outshot_set.dart';

class OutshotDetailPage extends StatelessWidget {
  final OutshotSet outshotSet;
  const OutshotDetailPage({super.key, required this.outshotSet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(outshotSet.name)),
      body: ListView.separated(
        itemCount: outshotSet.combinations.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final finish = outshotSet.combinations[index];
          return ListTile(
            title: Text('${finish.score}点'),
            subtitle: Text(finish.combination.join(' → ')),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('${finish.score}点のアウトショット'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('必要ダーツ数: ${finish.dartsNeeded}'),
                      const SizedBox(height: 8),
                      Text('ルート: ${finish.combination.join(' → ')}'),
                      const SizedBox(height: 8),
                      Text('説明: ${finish.description}'),
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
          );
        },
      ),
    );
  }
}
