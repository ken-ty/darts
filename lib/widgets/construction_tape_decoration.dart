import 'package:flutter/material.dart';

class ConstructionTapeDecoration extends Decoration {
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double? backgroundOpacity;
  final Color? stripeColor1;
  final Color? stripeColor2;
  final double? stripeWidth;
  final double? stripeGap;
  final Color? cardColor; // カードの色を追加

  const ConstructionTapeDecoration({
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.backgroundColor,
    this.backgroundOpacity,
    this.stripeColor1,
    this.stripeColor2,
    this.stripeWidth,
    this.stripeGap,
    this.cardColor,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _ConstructionTapePainter(
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      backgroundOpacity: backgroundOpacity,
      stripeColor1: stripeColor1,
      stripeColor2: stripeColor2,
      stripeWidth: stripeWidth,
      stripeGap: stripeGap,
      cardColor: cardColor,
    );
  }

  // copyWithメソッド
  ConstructionTapeDecoration copyWith({
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    double? backgroundOpacity,
    Color? stripeColor1,
    Color? stripeColor2,
    double? stripeWidth,
    double? stripeGap,
    Color? cardColor, // カードの色を追加
  }) {
    return ConstructionTapeDecoration(
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
      stripeColor1: stripeColor1 ?? this.stripeColor1,
      stripeColor2: stripeColor2 ?? this.stripeColor2,
      stripeWidth: stripeWidth ?? this.stripeWidth,
      stripeGap: stripeGap ?? this.stripeGap,
      cardColor: cardColor ?? this.cardColor, // カードの色を追加
    );
  }
}

class _ConstructionTapePainter extends BoxPainter {
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double? backgroundOpacity;
  final Color? stripeColor1;
  final Color? stripeColor2;
  final double? stripeWidth;
  final double? stripeGap;
  final Color? cardColor; // カードの色を追加

  _ConstructionTapePainter({
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.backgroundColor,
    this.backgroundOpacity,
    this.stripeColor1,
    this.stripeColor2,
    this.stripeWidth,
    this.stripeGap,
    this.cardColor, // カードの色を追加
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final rrect = RRect.fromRectAndRadius(
      rect,
      borderRadius?.topLeft ?? const Radius.circular(16),
    );

    // カードの形状に合わせてマスクを設定
    canvas.save();
    canvas.clipRRect(rrect);

    // 背景色（カードの色を使用）
    final bgColor = cardColor ?? Colors.white;
    final backgroundPaint = Paint()..color = bgColor;

    canvas.drawRRect(rrect, backgroundPaint);

    // ストライプの色とサイズ
    final stripe1Color = stripeColor1 ?? Colors.orange;
    final stripe2Color = stripeColor2 ?? Colors.black;
    const stripe1Opacity = 0.3;
    const stripe2Opacity = 0.2;
    final stripeStrokeWidth = stripeWidth ?? 6.0;
    final stripeGapSize = stripeGap ?? 20.0;

    // オレンジのストライプ
    final orangePaint = Paint()
      ..color = stripe1Color.withValues(alpha: stripe1Opacity)
      ..strokeWidth = stripeStrokeWidth
      ..style = PaintingStyle.stroke;

    // 黒のストライプ
    final blackPaint = Paint()
      ..color = stripe2Color.withValues(alpha: stripe2Opacity)
      ..strokeWidth = stripeStrokeWidth
      ..style = PaintingStyle.stroke;

    // 斜めのストライプを描画
    const stripePatternWidth = 10.0;

    for (
      double i = -rect.height;
      i < rect.width + rect.height;
      i += stripePatternWidth + stripeGapSize
    ) {
      // オレンジのストライプ
      canvas.drawLine(
        Offset(rect.left + i, rect.top),
        Offset(rect.left + i + rect.height, rect.bottom),
        orangePaint,
      );

      // 黒のストライプ（少しずらして）
      canvas.drawLine(
        Offset(rect.left + i + stripePatternWidth / 2, rect.top),
        Offset(
          rect.left + i + rect.height + stripePatternWidth / 2,
          rect.bottom,
        ),
        blackPaint,
      );
    }

    // マスクを解除
    canvas.restore();

    // ボーダーを描画
    final borderColorValue = borderColor ?? Colors.orange;
    final borderWidthValue = borderWidth ?? 1.0;

    if (borderWidthValue > 0) {
      final borderPaint = Paint()
        ..color = borderColorValue
        ..strokeWidth = borderWidthValue
        ..style = PaintingStyle.stroke;

      canvas.drawRRect(rrect, borderPaint);
    }
  }
}
