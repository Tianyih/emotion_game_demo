import 'dart:async';
import 'package:flutter/material.dart';

class ImagePreloader {
  static final Map<String, ImageProvider> _preloadedImages = {};
  static bool _isPreloading = false;
  static bool _isPreloaded = false;

  // 定义需要预加载的图片路径
  static const List<String> _imagePaths = [
    // 背景图片
    'assets/images/background/home_background_wide.png',
    'assets/images/background/game_background.png',
    'assets/images/background/help_background.png',
    'assets/images/background/cheer_background.png',
    'assets/images/background/levels_background.png',

    // 蜡烛图片
    'assets/images/candle/candle_lit.jpg',
    'assets/images/candle/candle_out.jpg',

    // 常用tile图片
    'assets/images/tiles/blue.png',
    'assets/images/tiles/green.png',
    'assets/images/tiles/orange.png',
    'assets/images/tiles/purple.png',
    'assets/images/tiles/red.png',
    'assets/images/tiles/yellow.png',
    'assets/images/tiles/turquoise.png',
    'assets/images/tiles/pink.png',
    'assets/images/tiles/multicolor.png',
    'assets/images/tiles/cream.png',
    'assets/images/tiles/choco.png',

    // 装饰图片
    'assets/images/deco/wall.png',
    'assets/images/deco/ice_01.png',
    'assets/images/deco/ice_02.png',

    // 炸弹图片
    'assets/images/bombs/mine.png',
    'assets/images/bombs/tnt.png',
    'assets/images/bombs/rocket.png',
    'assets/images/bombs/blue.png',
    'assets/images/bombs/green.png',
    'assets/images/bombs/orange.png',
    'assets/images/bombs/purple.png',
    'assets/images/bombs/red.png',
    'assets/images/bombs/yellow.png',

    // 边框图片
    'assets/images/borders/border_1.png',
    'assets/images/borders/border_2.png',
    'assets/images/borders/border_3.png',
    'assets/images/borders/border_4.png',
    'assets/images/borders/border_5.png',
    'assets/images/borders/border_7.png',
    'assets/images/borders/border_8.png',
    'assets/images/borders/border_10.png',
    'assets/images/borders/border_11.png',
    'assets/images/borders/border_12.png',
    'assets/images/borders/border_13.png',
    'assets/images/borders/border_14.png',
    'assets/images/borders/border_15.png',

    // 其他图片
    'assets/images/items/helper.jpg',
    'assets/images/levels/level_current.png',
    'assets/images/levels/level_done.png',
    'assets/images/levels/level_undone.png',
  ];

  /// 开始预加载所有图片
  static Future<void> preloadAllImages(BuildContext context) async {
    if (_isPreloading || _isPreloaded) return;

    _isPreloading = true;

    try {
      // 使用compute在后台线程预加载图片
      await Future.wait(
        _imagePaths.map((path) => _preloadImage(context, path)),
      );

      _isPreloaded = true;
      debugPrint('✅ All images preloaded');
    } catch (e) {
      debugPrint('❌ Image preloading failed: $e');
    } finally {
      _isPreloading = false;
    }
  }

  /// 预加载单个图片
  static Future<void> _preloadImage(BuildContext context, String path) async {
    try {
      final imageProvider = AssetImage(path);

      // 预加载图片到内存
      final imageStream = imageProvider.resolve(ImageConfiguration.empty);
      final completer = Completer<void>();

      final listener = ImageStreamListener((info, _) {
        completer.complete();
      }, onError: (error, stackTrace) {
        completer.completeError(error, stackTrace);
      });

      imageStream.addListener(listener);
      await completer.future;

      // 存储预加载的图片
      _preloadedImages[path] = imageProvider;

      debugPrint('✅ Preloaded image: $path');
    } catch (e) {
      debugPrint('❌ Preloading image failed: $path - $e');
    }
  }

  /// 获取预加载的图片
  static ImageProvider? getPreloadedImage(String path) {
    return _preloadedImages[path];
  }

  /// 检查图片是否已预加载
  static bool isImagePreloaded(String path) {
    return _preloadedImages.containsKey(path);
  }

  /// 获取预加载状态
  static bool get isPreloaded => _isPreloaded;
  static bool get isPreloading => _isPreloading;

  /// 清理预加载的图片（在内存不足时使用）
  static void clearPreloadedImages() {
    _preloadedImages.clear();
    _isPreloaded = false;
  }
}
