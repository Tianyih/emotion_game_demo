import 'package:flutter/material.dart';

import '../model/level.dart';
import '../bloc/bloc_provider.dart';
import '../bloc/game_bloc.dart';
import '../pages/game_page.dart';
import '../pages/cheer_page.dart';
import '../pages/home_page.dart';

class GameOverSplash extends StatefulWidget {
  const GameOverSplash({
    super.key,
    required this.success,
    required this.level,
    required this.onComplete,
    this.onCheerUpPressed,
  });

  final Level level;
  final VoidCallback onComplete;
  final VoidCallback? onCheerUpPressed;
  final bool success;

  @override
  _GameOverSplashState createState() => _GameOverSplashState();
}

class _GameOverSplashState extends State<GameOverSplash>
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
    );

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

    // Launch the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleButtonPressed() async {
    if (!mounted) return;

    final gameBloc = BlocProvider.of<GameBloc>(context)?.bloc;

    if (widget.success) {
      // Check if this is the last level
      if (gameBloc != null) {
        final currentLevel = widget.level.index;
        final nextLevelIndex = currentLevel + 1;

        // Check if next level exists
        if (nextLevelIndex <= gameBloc.numberOfLevels) {
          try {
            Level nextLevel = await gameBloc.setLevel(nextLevelIndex);
            if (!mounted) return;

            // Don't call widget.onComplete() here to avoid Navigator conflicts
            // Instead, directly navigate and let the new page replace everything
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => GamePage(level: nextLevel),
              ),
              (route) => route.isFirst, // Keep only the home page in stack
            );
            return;
          } catch (e) {
            // If there's an error loading the next level, just go back
          }
        } else {
          // This is the last level - navigate to home page
          widget.onComplete();

          // Use post frame callback to navigate to home page
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            }
          });
          return;
        }
      }
      // If no gameBloc or other error, just complete
      widget.onComplete();
    } else {
      // Cheer up action - use custom callback if provided, otherwise navigate directly
      if (widget.onCheerUpPressed != null) {
        widget.onCheerUpPressed!();
      } else {
        // Fallback: Remove current splash first, then navigate
        widget.onComplete();

        // Use a post frame callback to ensure the overlay is removed first
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CheerPage(),
              ),
            );
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    // Colors for success (win) state
    Color backgroundColor =
        widget.success ? Colors.green[100]! : const Color(0xFFBCCBFF);
    Color borderColor = widget.success ? Colors.green[700]! : Colors.blue[700]!;

    // Check if this is the last level
    final gameBloc = BlocProvider.of<GameBloc>(context)?.bloc;
    bool isLastLevel = false;
    if (gameBloc != null) {
      final currentLevel = widget.level.index;
      final nextLevelIndex = currentLevel + 1;
      isLastLevel = nextLevelIndex > gameBloc.numberOfLevels;
    }

    // Messages and button text
    String message;
    String buttonText;

    if (widget.success) {
      if (isLastLevel) {
        message = "You have completed all levels!";
        buttonText = "Back to Home";
      } else {
        message = "Congrats! You have completed this level.";
        buttonText = "Next Level";
      }
    } else {
      message = "Oh no! You failed this level.";
      buttonText = "Cheer Yourself Up";
    }

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
                constraints: const BoxConstraints(maxWidth: 350),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  border: Border.all(color: borderColor, width: 3),
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
                    // Icon
                    Icon(
                      widget.success
                          ? Icons.celebration
                          : Icons.sentiment_dissatisfied,
                      size: 60,
                      color: borderColor,
                    ),
                    const SizedBox(height: 20),

                    // Message
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'ICELAND',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: borderColor,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleButtonPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: borderColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            fontFamily: 'ICELAND',
                            fontSize: 20,
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
