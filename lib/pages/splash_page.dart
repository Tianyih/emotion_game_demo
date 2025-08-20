import 'package:flutter/material.dart';
import '../utils/image_preloader.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _progress = 0.0;
  String _loadingText = '正在加载...';

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  Future<void> _startLoading() async {
    // 模拟加载进度
    for (int i = 0; i <= 100; i += 10) {
      if (mounted) {
        setState(() {
          _progress = i / 100;
          if (i < 30) {
            _loadingText = '初始化应用...';
          } else if (i < 60) {
            _loadingText = '加载游戏资源...';
          } else if (i < 90) {
            _loadingText = '预加载图片...';
          } else {
            _loadingText = '准备完成...';
          }
        });
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // 开始预加载图片
    if (mounted) {
      setState(() {
        _loadingText = '预加载图片资源...';
      });

      await ImagePreloader.preloadAllImages(context);
    }

    // 导航到主页
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 游戏图标
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFff6b6b),
                    Color(0xFF4ecdc4),
                  ],
                ),
              ),
              child: const Icon(
                Icons.games,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 40),

            // 游戏标题
            const Text(
              'Emotion Game',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'ICELAND',
              ),
            ),

            const SizedBox(height: 60),

            // 加载进度条
            Container(
              width: 200,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _progress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFff6b6b),
                        Color(0xFF4ecdc4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 加载文本
            Text(
              _loadingText,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 10),

            // 进度百分比
            Text(
              '${(_progress * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
