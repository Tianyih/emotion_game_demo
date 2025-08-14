import 'package:candycrush/panel/objective/components/objective_item.dart';
import 'package:flutter/material.dart';

import '../model/level.dart';

class GameSplash extends StatefulWidget {
  const GameSplash({
    super.key,
    required this.level,
    this.onComplete,
  });

  final Level level;
  final VoidCallback? onComplete;

  @override
  _GameSplashState createState() => _GameSplashState();
}

class _GameSplashState extends State<GameSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationScale;
  late Animation<double> _animationOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          // Wait 3 seconds after animation completes, then auto-close
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted && widget.onComplete != null) {
              widget.onComplete?.call();
            }
          });
        }
      });

    _animationScale = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _animationOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // Play the intro
    // Audio.playAsset(AudioType.game_start);

    // Launch the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleStartGame() {
    if (widget.onComplete != null) {
      widget.onComplete?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    List<Widget> objectiveWidgets = widget.level.objectives.map((obj) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ObjectiveItem(objective: obj, level: widget.level),
      );
    }).toList();

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Material(
          color: Colors.black.withOpacity(0.5 * _animationOpacity.value),
          child: Center(
            child: Transform.scale(
              scale: _animationScale.value,
              child: Container(
                width: screenSize.width * 0.8,
                constraints: const BoxConstraints(maxWidth: 400),
                decoration: BoxDecoration(
                  color: Colors.blue[100]!,
                  border: Border.all(color: Colors.blue[700]!, width: 3),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Level title
                    Icon(
                      Icons.play_circle_filled,
                      size: 60,
                      color: Colors.blue[700],
                    ),
                    const SizedBox(height: 20),

                    // Level number
                    Text(
                      'Level ${widget.level.index}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'ICELAND',
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Objectives title
                    Text(
                      'Objectives:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'ICELAND',
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Objectives list
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: objectiveWidgets,
                    ),
                    const SizedBox(height: 30),

                    // Start button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleStartGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Start Game',
                          style: TextStyle(
                            fontFamily: 'ICELAND',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
