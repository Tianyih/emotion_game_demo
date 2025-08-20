import 'package:flutter/material.dart';
import 'image_preloader.dart';

class OptimizedImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool usePreloadedImage;

  const OptimizedImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.usePreloadedImage = true,
  });

  @override
  Widget build(BuildContext context) {
    // 如果启用了预加载且图片已预加载，使用预加载的图片
    if (usePreloadedImage && ImagePreloader.isImagePreloaded(imagePath)) {
      final preloadedImage = ImagePreloader.getPreloadedImage(imagePath);
      if (preloadedImage != null) {
        return Image(
          image: preloadedImage,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? _buildDefaultErrorWidget();
          },
        );
      }
    }

    // 否则使用普通的AssetImage
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? _buildDefaultErrorWidget();
      },
    );
  }

  Widget _buildDefaultErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(
          Icons.error,
          color: Colors.grey,
        ),
      ),
    );
  }
}

/// 获取优化的装饰图片
class OptimizedDecorationImage {
  static BoxDecoration getDecorationImage({
    required String imagePath,
    BoxFit fit = BoxFit.cover,
    bool usePreloadedImage = true,
  }) {
    // 如果启用了预加载且图片已预加载，使用预加载的图片
    if (usePreloadedImage && ImagePreloader.isImagePreloaded(imagePath)) {
      final preloadedImage = ImagePreloader.getPreloadedImage(imagePath);
      if (preloadedImage != null) {
        return BoxDecoration(
          image: DecorationImage(
            image: preloadedImage,
            fit: fit,
          ),
        );
      }
    }

    // 否则使用普通的AssetImage
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: fit,
      ),
    );
  }
}
