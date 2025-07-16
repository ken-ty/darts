import 'package:flutter/material.dart';
import 'package:outshotx/l10n/app_localizations.dart';

import '../constants/feature_flags.dart';
import '../models/finish_combination.dart';
import '../models/user_profile.dart';
import '../services/darts_calculator.dart';
import '../widgets/finish_card.dart';
import '../widgets/under_development_overlay.dart';

class PracticePage extends StatefulWidget {
  final UserProfile user;

  const PracticePage({super.key, required this.user});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int _currentScore = 301;
  final List<int> _scoreHistory = [301];
  final TextEditingController _inputController = TextEditingController();

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
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  List<FinishCombination> get _availableFinishes {
    final finishes = <FinishCombination>[];

    // ユーザーのカスタムフィニッシュ
    final userFinish = widget.user.finishBoard[_currentScore];
    if (userFinish != null) {
      finishes.add(userFinish);
    }

    // 提案されたフィニッシュ
    final suggestions = DartsCalculator.getSuggestedFinishes(_currentScore);
    for (final suggestion in suggestions) {
      if (!finishes.any(
        (f) =>
            f.score == suggestion.score &&
            f.combination.join(',') == suggestion.combination.join(','),
      )) {
        finishes.add(suggestion);
      }
    }

    return finishes;
  }

  @override
  Widget build(BuildContext context) {
    // プラクティス機能が無効な場合は開発中表示
    if (!FeatureFlags.enablePractice) {
      return _buildUnderDevelopmentContent();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          AppLocalizations.of(context)?.practice ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _resetGame,
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: _showGameSettings,
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Score Display
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)?.remainingScore ?? '',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimary.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$_currentScore',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 64,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildStatusChip(_getGameStatus(), _getStatusColor()),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Score Input
                Text(
                  AppLocalizations.of(context)?.scoreInput ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _inputController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)?.enterScore ?? '',
                          hintStyle: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.5),
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
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: _subtractScore,
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Quick Score Buttons
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...DartsCalculator.getCommonCheckouts().map((checkout) {
                      final score =
                          int.tryParse(checkout.split('(')[1].split(')')[0]) ??
                          0;
                      return _buildQuickScoreButton(score);
                    }),
                  ],
                ),

                const SizedBox(height: 16),

                // Undo Button
                if (_scoreHistory.length > 1)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _undoLastScore,
                      icon: Icon(
                        Icons.undo,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: Text(
                        AppLocalizations.of(context)?.undoLastScore ?? '',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 32),

                // Available Finishes
                if (_availableFinishes.isNotEmpty) ...[
                  Text(
                    AppLocalizations.of(context)?.finishCandidates ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _availableFinishes.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final finish = _availableFinishes[index];
                      return FinishCard(
                        finish: finish,
                        onTap: () => _showFinishDetail(finish),
                      );
                    },
                  ),
                ] else if (_currentScore <= 180) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.tertiary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.tertiary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)?.noFinishCandidates ??
                              '',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(
                                context,
                              )?.noFinishCandidatesDescription ??
                              '',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
      ),
      child: Text(
        status,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildQuickScoreButton(int score) {
    return InkWell(
      onTap: () => _quickSubtract(score),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.secondary.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          '$score',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _subtractScore() {
    final inputText = _inputController.text.trim();
    if (inputText.isEmpty) return;

    final score = int.tryParse(inputText);
    if (score == null || score < 0 || score > 180) {
      _showErrorDialog(
        AppLocalizations.of(context)?.invalidScore ?? '',
        AppLocalizations.of(context)?.invalidScoreMessage ?? '',
      );
      return;
    }

    if (DartsCalculator.isBustScore(_currentScore, score)) {
      _showErrorDialog(
        AppLocalizations.of(context)?.bust ?? '',
        AppLocalizations.of(context)?.bustMessage ?? '',
      );
      return;
    }

    setState(() {
      _currentScore = DartsCalculator.calculateRemainingScore(
        _currentScore,
        score,
      );
      _scoreHistory.add(_currentScore);
      _inputController.clear();
    });

    if (_currentScore == 0) {
      _showGameFinishedDialog();
    }
  }

  void _quickSubtract(int score) {
    if (DartsCalculator.isBustScore(_currentScore, score)) {
      _showErrorDialog(
        AppLocalizations.of(context)?.bust ?? '',
        AppLocalizations.of(context)?.bustQuickMessage ?? '',
      );
      return;
    }

    setState(() {
      _currentScore = DartsCalculator.calculateRemainingScore(
        _currentScore,
        score,
      );
      _scoreHistory.add(_currentScore);
    });

    if (_currentScore == 0) {
      _showGameFinishedDialog();
    }
  }

  void _undoLastScore() {
    if (_scoreHistory.length > 1) {
      setState(() {
        _scoreHistory.removeLast();
        _currentScore = _scoreHistory.last;
      });
    }
  }

  void _resetGame() {
    setState(() {
      _currentScore = 301;
      _scoreHistory.clear();
      _scoreHistory.add(301);
      _inputController.clear();
    });
  }

  String _getGameStatus() {
    if (_currentScore == 0) {
      return AppLocalizations.of(context)?.gameFinished ?? '';
    } else if (_currentScore <= 40 && _currentScore % 2 == 0) {
      return AppLocalizations.of(context)?.finishPossible ?? '';
    } else if (_currentScore <= 60) {
      return AppLocalizations.of(context)?.finishRange ?? '';
    } else if (_currentScore <= 100) {
      return AppLocalizations.of(context)?.goodPosition ?? '';
    } else {
      return AppLocalizations.of(context)?.inProgress ?? '';
    }
  }

  Color _getStatusColor() {
    if (_currentScore == 0) {
      return Theme.of(context).colorScheme.tertiary;
    } else if (_currentScore <= 40) {
      return Colors.green;
    } else if (_currentScore <= 100) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }

  void _showFinishDetail(FinishCombination finish) {
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
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  _quickSubtract(finish.score);
                },
                child: Text(
                  AppLocalizations.of(context)?.finishWithThis ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)?.ok ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }

  void _showGameFinishedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.celebration,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)?.congratulations ?? '',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          AppLocalizations.of(context)?.gameFinishedMessage ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context)?.end ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
            },
            child: Text(
              AppLocalizations.of(context)?.newGame ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }

  void _showGameSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)?.gameSettings ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.sports_esports,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('301'),
              subtitle: Text(AppLocalizations.of(context)?.standardGame ?? ''),
              onTap: () {
                setState(() {
                  _currentScore = 301;
                  _scoreHistory.clear();
                  _scoreHistory.add(301);
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.sports_esports,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: const Text('301'),
              subtitle: Text(AppLocalizations.of(context)?.shortGame ?? ''),
              onTap: () {
                setState(() {
                  _currentScore = 301;
                  _scoreHistory.clear();
                  _scoreHistory.add(301);
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.sports_esports,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              title: const Text('701'),
              subtitle: Text(AppLocalizations.of(context)?.longGame ?? ''),
              onTap: () {
                setState(() {
                  _currentScore = 701;
                  _scoreHistory.clear();
                  _scoreHistory.add(701);
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)?.cancel ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnderDevelopmentContent() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          AppLocalizations.of(context)?.practice ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: UnderDevelopmentOverlay(
        backgroundContent: _buildPracticeContent(),
        title: AppLocalizations.of(context)?.underDevelopment ?? '',
        description:
            AppLocalizations.of(context)?.practiceUnderDevelopment ?? '',
        primaryColor: Theme.of(context).colorScheme.secondary,
        secondaryColor: Theme.of(context).colorScheme.tertiary,
        progressPercentage: 0.1,
        progressText: '10% Complete',
      ),
    );
  }

  Widget _buildPracticeContent() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Score Display
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)?.remainingScore ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onPrimary.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_currentScore',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 64,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStatusChip(_getGameStatus(), _getStatusColor()),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // 他のコンテンツも同様に追加...
            ],
          ),
        ),
      ),
    );
  }
}
