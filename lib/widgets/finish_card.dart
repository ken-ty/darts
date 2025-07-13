import 'package:flutter/material.dart';

import '../models/finish_combination.dart';

class FinishCard extends StatelessWidget {
  final FinishCombination finish;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final bool isCompact;

  const FinishCard({
    super.key,
    required this.finish,
    this.onTap,
    this.onEdit,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(isCompact ? 12 : 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Score header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getScoreColor(context, finish.score),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${finish.score}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (onEdit != null)
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.outline,
                      size: 18,
                    ),
                    iconSize: 18,
                    constraints: const BoxConstraints(
                      minHeight: 32,
                      minWidth: 32,
                    ),
                  ),
              ],
            ),

            SizedBox(height: isCompact ? 8 : 12),

            // Dart count indicator
            Row(
              children: [
                ...List.generate(
                  3,
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index < finish.dartsNeeded
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${finish.dartsNeeded}ダーツ',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: isCompact ? 8 : 12),

            // Combination display
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: finish.combination.map((dart) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getDartColor(context, dart).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _getDartColor(
                        context,
                        dart,
                      ).withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _formatDart(dart),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: _getDartColor(context, dart),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),

            if (!isCompact) ...[
              const SizedBox(height: 8),
              Text(
                finish.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(BuildContext context, int score) {
    if (score >= 150) {
      return Theme.of(context).colorScheme.error;
    } else if (score >= 100) {
      return Theme.of(context).colorScheme.tertiary;
    } else if (score >= 50) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      return Theme.of(context).colorScheme.primary;
    }
  }

  Color _getDartColor(BuildContext context, String dart) {
    if (dart.startsWith('T')) {
      return Theme.of(context).colorScheme.error;
    } else if (dart.startsWith('D')) {
      return Theme.of(context).colorScheme.secondary;
    } else if (dart == 'Bull') {
      return Theme.of(context).colorScheme.tertiary;
    } else {
      return Theme.of(context).colorScheme.primary;
    }
  }

  String _formatDart(String dart) {
    if (dart.startsWith('S')) {
      return dart.substring(1);
    } else if (dart.startsWith('D')) {
      return 'D${dart.substring(1)}';
    } else if (dart.startsWith('T')) {
      return 'T${dart.substring(1)}';
    } else if (dart == 'Bull') {
      return 'Bull';
    }
    return dart;
  }
}
