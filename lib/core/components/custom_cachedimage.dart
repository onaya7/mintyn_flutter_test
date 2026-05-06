import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/helpers/ui_helpers.dart';
import 'package:shimmer/shimmer.dart';

/// A reusable cached network image widget that abstracts the caching implementation
/// This makes it easy to switch to another caching package in the future
class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.shape = ImageShape.rectangle,
    this.borderRadius,
    this.radius = 30.0,
    this.backgroundColor,
    this.placeholder,
    this.errorWidget,
    this.errorIcon = Icons.image_not_supported_outlined,
    this.errorIconSize,
    this.showShimmer = true,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.borderColor,
    this.borderWidth = 1.5,
  });

  /// Factory constructor for circular images
  factory CustomCachedImage.circular({
    required String imageUrl,
    Key? key,
    double radius = 30.0,
    Color? backgroundColor,
    Widget? placeholder,
    Widget? errorWidget,
    IconData errorIcon = Icons.person_outline,
    double? errorIconSize,
    bool showShimmer = true,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
    Color? borderColor,
    double borderWidth = 1.5,
  }) {
    return CustomCachedImage(
      key: key,
      imageUrl: imageUrl,
      shape: ImageShape.circle,
      radius: radius,
      backgroundColor: backgroundColor,
      placeholder: placeholder,
      errorWidget: errorWidget,
      errorIcon: errorIcon,
      errorIconSize: errorIconSize,
      showShimmer: showShimmer,
      shimmerBaseColor: shimmerBaseColor,
      shimmerHighlightColor: shimmerHighlightColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }

  /// Factory constructor for rectangular images
  factory CustomCachedImage.rectangle({
    required String imageUrl,
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    Widget? placeholder,
    Widget? errorWidget,
    IconData errorIcon = Icons.image_not_supported_outlined,
    double? errorIconSize,
    bool showShimmer = true,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
  }) {
    return CustomCachedImage(
      key: key,
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      placeholder: placeholder,
      errorWidget: errorWidget,
      errorIcon: errorIcon,
      errorIconSize: errorIconSize,
      showShimmer: showShimmer,
      shimmerBaseColor: shimmerBaseColor,
      shimmerHighlightColor: shimmerHighlightColor,
    );
  }

  /// The URL of the image to display
  final String imageUrl;

  /// The width of the image (optional)
  final double? width;

  /// The height of the image (optional)
  final double? height;

  /// How the image should fit within its bounds
  final BoxFit fit;

  /// The shape of the image (rectangle, circle, etc.)
  final ImageShape shape;

  /// Border radius for rounded corners (only applies to rectangle shape)
  final BorderRadius? borderRadius;

  /// Radius for circular images (only applies to circle shape)
  final double radius;

  /// Background color for placeholder and error states
  final Color? backgroundColor;

  /// Custom placeholder widget (optional)
  final Widget? placeholder;

  /// Custom error widget (optional)
  final Widget? errorWidget;

  /// Icon to show in error state
  final IconData errorIcon;

  /// Size of the error icon
  final double? errorIconSize;

  /// Whether to show a loading shimmer effect
  final bool showShimmer;

  /// Custom shimmer colors
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;

  /// Border properties for error state
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    // If imageUrl is empty or null, show error widget immediately
    if (imageUrl.isEmpty) {
      return _buildErrorWidget(context);
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: shape == ImageShape.circle ? radius * 2 : width,
      height: shape == ImageShape.circle ? radius * 2 : height,
      fit: fit,
      imageBuilder: (context, imageProvider) => _buildImageWidget(imageProvider),
      placeholder: (context, url) => placeholder ?? _buildPlaceholderWidget(context),
      errorWidget: (context, url, error) => errorWidget ?? _buildErrorWidget(context),
    );
  }

  Widget _buildImageWidget(ImageProvider imageProvider) {
    if (shape == ImageShape.circle) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: imageProvider,
        backgroundColor: backgroundColor ?? Colors.grey.shade200,
      );
    } else {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(image: imageProvider, fit: fit),
        ),
      );
    }
  }

  Widget _buildPlaceholderWidget(BuildContext context) {
    final baseWidget = shape == ImageShape.circle
        ? CircleAvatar(
            radius: radius,
            backgroundColor: backgroundColor ?? Colors.grey.shade200,
            child: Icon(Icons.person_outline, size: errorIconSize ?? radius * 0.6, color: Colors.grey.shade400),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(color: backgroundColor ?? Colors.grey.shade200, borderRadius: borderRadius),
            child: Icon(Icons.image_outlined, size: errorIconSize ?? 40, color: Colors.grey.shade400),
          );

    if (showShimmer) {
      final isDark = UiHelpers.isDarkMode(context);
      return Shimmer.fromColors(
        baseColor: shimmerBaseColor ?? (isDark ? Colors.white24 : Colors.grey.shade300),
        highlightColor: shimmerHighlightColor ?? (isDark ? Colors.white12 : Colors.grey.shade100),
        child: baseWidget,
      );
    }

    return baseWidget;
  }

  Widget _buildErrorWidget(BuildContext context) {
    final isDark = UiHelpers.isDarkMode(context);
    const defaultBorderColor = Colors.transparent;
    final defaultIconColor = isDark ? Colors.white : AppColor.black;

    if (shape == ImageShape.circle) {
      return Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor ?? defaultBorderColor, width: borderWidth),
        ),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor ?? Colors.grey.shade200.withValues(alpha: 0.3),
          child: Icon(errorIcon, color: defaultIconColor, size: errorIconSize ?? radius * 0.6),
        ),
      );
    } else {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey.shade200.withValues(alpha: 0.3),
          borderRadius: borderRadius,
          border: Border.all(color: borderColor ?? defaultBorderColor, width: borderWidth),
        ),
        child: Icon(errorIcon, color: defaultIconColor, size: errorIconSize ?? 40),
      );
    }
  }
}

/// Enum to define the shape of the image
enum ImageShape { rectangle, circle }
