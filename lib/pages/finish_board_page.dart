import 'package:flutter/material.dart';

import '../models/finish_combination.dart';
import '../models/user_profile.dart';
import '../services/user_service.dart';
import '../widgets/finish_card.dart';

class FinishBoardPage extends StatefulWidget {
  final UserProfile user;

  const FinishBoardPage({super.key, required this.user});

  @override
  State<FinishBoardPage> createState() => _FinishBoardPageState();
}

class _FinishBoardPageState extends State<FinishBoardPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String _searchQuery = '';
  int? _selectedScore;
  bool _isGridView = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<int> get _filteredScores {
    List<int> scores = List.generate(180, (index) => index + 1);

    if (_searchQuery.isNotEmpty) {
      try {
        int.parse(_searchQuery);
        scores = scores
            .where((score) => score.toString().contains(_searchQuery))
            .toList();
      } catch (e) {
        scores = [];
      }
    }

    return scores;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          'フィニッシュボード',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            icon: Icon(
              _isGridView ? Icons.view_list : Icons.grid_view,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: _showFilterDialog,
            icon: Icon(
              Icons.filter_list,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'スコアを検索 (例: 170)',
                  hintStyle: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            // Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${widget.user.finishBoard.length}',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '登録済み',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${180 - widget.user.finishBoard.length}',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '未登録',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Finish Board
            Expanded(child: _isGridView ? _buildGridView() : _buildListView()),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _filteredScores.length,
        itemBuilder: (context, index) {
          final score = _filteredScores[index];
          final finish = widget.user.finishBoard[score];

          return _buildScoreCard(score, finish);
        },
      ),
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredScores.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final score = _filteredScores[index];
        final finish = widget.user.finishBoard[score];

        if (finish != null) {
          return FinishCard(
            finish: finish,
            onTap: () => _showFinishDetail(score, finish),
            onEdit: () => _editFinish(score, finish),
          );
        } else {
          return _buildEmptyFinishCard(score);
        }
      },
    );
  }

  Widget _buildScoreCard(int score, FinishCombination? finish) {
    final hasFinish = finish != null;

    return InkWell(
      onTap: () {
        if (hasFinish) {
          _showFinishDetail(score, finish);
        } else {
          _addFinish(score);
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: hasFinish
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: hasFinish
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$score',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: hasFinish
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            if (hasFinish) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 2),
                    width: 4,
                    height: 4,
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
              ),
            ] else ...[
              Icon(
                Icons.add,
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.5),
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyFinishCard(int score) {
    return InkWell(
      onTap: () => _addFinish(score),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$score',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'タップして追加',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
            Icon(
              Icons.add_circle_outline,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }

  void _showFinishDetail(int score, FinishCombination finish) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            FinishCard(finish: finish, isCompact: false),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _editFinish(score, finish);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: Text(
                      '編集',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _deleteFinish(score);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.onError,
                    ),
                    label: Text(
                      '削除',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onError,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addFinish(int score) {
    // TODO: Navigate to finish editor
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$scoreのフィニッシュを追加')));
  }

  void _editFinish(int score, FinishCombination finish) {
    // TODO: Navigate to finish editor
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$scoreのフィニッシュを編集')));
  }

  void _deleteFinish(int score) async {
    await UserService.removeFinishCombination(widget.user.id, score);
    setState(() {});
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$scoreのフィニッシュを削除しました')));
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'フィルター',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('すべて表示'),
              trailing: _selectedScore == null
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _selectedScore = null;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('登録済みのみ'),
              trailing: _selectedScore == -1
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _selectedScore = -1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('未登録のみ'),
              trailing: _selectedScore == -2
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _selectedScore = -2;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
