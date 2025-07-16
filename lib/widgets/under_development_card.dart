import 'package:flutter/material.dart';
import 'package:outshotx/l10n/app_localizations.dart';

class UnderDevelopmentCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const UnderDevelopmentCard({super.key, required this.child, this.onTap});

  @override
  State<UnderDevelopmentCard> createState() => _UnderDevelopmentCardState();
}

class _UnderDevelopmentCardState extends State<UnderDevelopmentCard>
    with TickerProviderStateMixin {
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();

    // 点滅アニメーション（工事アイコン用）
    _blinkController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _blinkAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _blinkController,
      builder: (context, child) {
        return Stack(
          children: [
            // メインのカードコンテンツ
            widget.child,

            // 控えめな開発中オーバーレイ
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.orange.withValues(alpha: 0.08),
                        Colors.deepOrange.withValues(alpha: 0.04),
                        Colors.orange.withValues(alpha: 0.08),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 工事テープ風の斜めストライプ
            Positioned.fill(
              child: IgnorePointer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CustomPaint(painter: ConstructionTapePainter()),
                ),
              ),
            ),

            // 開発中テキスト（右上）
            Positioned(
              top: 8,
              right: 8,
              child: IgnorePointer(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    AppLocalizations.of(context)?.underDevelopment ?? '開発中',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// 工事テープ風の斜めストライプを描画するカスタムペインター
class ConstructionTapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // オレンジのストライプ（薄く）
    final orangePaint = Paint()
      ..color = Colors.orange.withValues(alpha: 0.3)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    // 黒のストライプ（薄く）
    final blackPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    // より密な斜めのストライプを描画
    const stripeWidth = 10.0;
    const stripeGap = 20.0;

    for (
      double i = -size.height;
      i < size.width + size.height;
      i += stripeWidth + stripeGap
    ) {
      // オレンジのストライプ
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        orangePaint,
      );

      // 黒のストライプ（少しずらして）
      canvas.drawLine(
        Offset(i + stripeWidth / 2, 0),
        Offset(i + size.height + stripeWidth / 2, size.height),
        blackPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
