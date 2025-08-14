import 'package:flutter/material.dart';
import '../model/combo.dart';
import '../model/tile.dart';

class AnimationComboThree extends StatefulWidget {
  const AnimationComboThree({
    super.key,
    required this.combo,
    required this.onComplete,
  });

  final Combo combo;
  final VoidCallback onComplete;

  @override
  State<AnimationComboThree> createState() => _AnimationComboThreeState();
}

class _AnimationComboThreeState extends State<AnimationComboThree>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Map<Tile, Animation<double>> _tileAnimations = {};

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });

    // 针对不同tile类型生成动画
    for (Tile tile in widget.combo.tiles) {
      late Animation<double> anim;
      // 正面情感放大
      final isZoom = tile.type == TileType.yellow || tile.type == TileType.orange;
      if (isZoom) {
        // 放大再缩小消失
        anim = TweenSequence([
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.4)
                  .chain(CurveTween(curve: Curves.easeOut)),
              weight: 50),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.4, end: 0.0)
                  .chain(CurveTween(curve: Curves.easeIn)),
              weight: 50),
        ]).animate(_controller);
      } else {
        // 负面情感缩小直至消失
        anim = TweenSequence([
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 0.0)
                  .chain(CurveTween(curve: Curves.easeOut)),
              weight: 50),
        ]).animate(_controller);
      }

      _tileAnimations[tile] = anim;
    }

    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.combo.tiles.map((tile) {
        final animation = _tileAnimations[tile]!;

        return Positioned(
          left: tile.x,
          top: tile.y,
          child: AnimatedBuilder(
            animation: animation,
            builder: (_, __) {
              return Transform.scale(
                scale: animation.value,
                child: tile.widget,
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
