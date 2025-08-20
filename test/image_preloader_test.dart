import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:candycrush/utils/image_preloader.dart';

void main() {
  group('ImagePreloader Tests', () {
    testWidgets('ImagePreloader initialization', (WidgetTester tester) async {
      // 测试初始状态
      expect(ImagePreloader.isPreloaded, false);
      expect(ImagePreloader.isPreloading, false);

      // 测试预加载状态
      expect(
          ImagePreloader.isImagePreloaded(
              'assets/images/background/home_background_wide.png'),
          false);
    });

    testWidgets('ImagePreloader preload images', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold()));

      // 开始预加载
      await ImagePreloader.preloadAllImages(
          tester.element(find.byType(Scaffold)));

      // 等待预加载完成
      await tester.pumpAndSettle();

      // 验证预加载状态
      expect(ImagePreloader.isPreloaded, true);
      expect(ImagePreloader.isPreloading, false);

      // 验证特定图片是否已预加载
      expect(
          ImagePreloader.isImagePreloaded(
              'assets/images/background/home_background_wide.png'),
          true);
      expect(
          ImagePreloader.isImagePreloaded(
              'assets/images/background/game_background.png'),
          true);
    });

    test('ImagePreloader clear images', () {
      // 清理预加载的图片
      ImagePreloader.clearPreloadedImages();

      // 验证清理状态
      expect(ImagePreloader.isPreloaded, false);
      expect(ImagePreloader.isPreloading, false);
    });
  });
}
