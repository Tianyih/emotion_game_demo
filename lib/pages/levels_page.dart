import 'package:flutter/material.dart';
import 'home_page.dart';
import 'game_page.dart';
import '../bloc/bloc_provider.dart';
import '../bloc/game_bloc.dart';
import '../model/level.dart';

class LevelsPage extends StatefulWidget {
  const LevelsPage({super.key});

  @override
  State<LevelsPage> createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  late GameBloc _gameBloc;

  @override
  void initState() {
    super.initState();
    _gameBloc = BlocProvider.of<GameBloc>(context)!.bloc;
  }

  Future<void> _navigateToLevel(int levelIndex) async {
    try {
      Level level = await _gameBloc.setLevel(levelIndex);
      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GamePage(level: level),
        ),
      );
    } catch (e) {
      // Handle error - maybe show a snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load level $levelIndex')),
        );
      }
    }
  }

  Widget _buildLevelButton(int levelIndex) {
    bool isEnabled = levelIndex == 1; // Only level 1 is enabled

    return GestureDetector(
      onTap: isEnabled ? () => _navigateToLevel(levelIndex) : null,
      child: Container(
        width: 320,
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.green[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(20), // 圆角方框
          border: Border.all(
            color: isEnabled ? Colors.green[700]! : Colors.grey[500]!,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Level text at top
            Positioned(
              top: 15,
              left: 0,
              right: 0,
              child: Text(
                'LEVEL $levelIndex',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'ICELAND',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isEnabled ? Colors.green[700] : Colors.grey[600],
                ),
              ),
            ),
            // Status icon/indicator
            Positioned(
              bottom: 15,
              right: 20,
              child: Icon(
                isEnabled ? Icons.play_circle_filled : Icons.lock,
                size: 35,
                color: isEnabled ? Colors.green[700] : Colors.grey[600],
              ),
            ),
            // Disabled overlay
            if (!isEnabled)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/levels_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Title
                  Text(
                    'SELECT LEVEL',
                    style: TextStyle(
                      fontFamily: 'ICELAND',
                      fontSize: 58,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Level buttons (1-5)
                  ...List.generate(5, (index) {
                    final levelIndex = index + 1;
                    return _buildLevelButton(levelIndex);
                  }),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
