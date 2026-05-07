/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsFontGen {
  const $AssetsFontGen();

  /// File path: assets/font/Arimo-Bold.ttf
  String get arimoBold => 'assets/font/Arimo-Bold.ttf';

  /// File path: assets/font/Arimo-BoldItalic.ttf
  String get arimoBoldItalic => 'assets/font/Arimo-BoldItalic.ttf';

  /// File path: assets/font/Arimo-Italic.ttf
  String get arimoItalic => 'assets/font/Arimo-Italic.ttf';

  /// File path: assets/font/Arimo-Medium.ttf
  String get arimoMedium => 'assets/font/Arimo-Medium.ttf';

  /// File path: assets/font/Arimo-MediumItalic.ttf
  String get arimoMediumItalic => 'assets/font/Arimo-MediumItalic.ttf';

  /// File path: assets/font/Arimo-Regular.ttf
  String get arimoRegular => 'assets/font/Arimo-Regular.ttf';

  /// File path: assets/font/Arimo-SemiBold.ttf
  String get arimoSemiBold => 'assets/font/Arimo-SemiBold.ttf';

  /// File path: assets/font/Arimo-SemiBoldItalic.ttf
  String get arimoSemiBoldItalic => 'assets/font/Arimo-SemiBoldItalic.ttf';

  /// List of all assets
  List<String> get values => [
        arimoBold,
        arimoBoldItalic,
        arimoItalic,
        arimoMedium,
        arimoMediumItalic,
        arimoRegular,
        arimoSemiBold,
        arimoSemiBoldItalic
      ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/add_plus.svg
  SvgGenImage get addPlus => const SvgGenImage('assets/icons/add_plus.svg');

  /// File path: assets/icons/arrow_up_right.svg
  SvgGenImage get arrowUpRight =>
      const SvgGenImage('assets/icons/arrow_up_right.svg');

  /// File path: assets/icons/bankingfee.svg
  SvgGenImage get bankingfee =>
      const SvgGenImage('assets/icons/bankingfee.svg');

  /// File path: assets/icons/barcode.svg
  SvgGenImage get barcode => const SvgGenImage('assets/icons/barcode.svg');

  /// File path: assets/icons/bell_notification.svg
  SvgGenImage get bellNotification =>
      const SvgGenImage('assets/icons/bell_notification.svg');

  /// File path: assets/icons/billpay.svg
  SvgGenImage get billpay => const SvgGenImage('assets/icons/billpay.svg');

  /// File path: assets/icons/deposit.svg
  SvgGenImage get deposit => const SvgGenImage('assets/icons/deposit.svg');

  /// File path: assets/icons/donations.svg
  SvgGenImage get donations => const SvgGenImage('assets/icons/donations.svg');

  /// File path: assets/icons/ewallet.svg
  SvgGenImage get ewallet => const SvgGenImage('assets/icons/ewallet.svg');

  /// File path: assets/icons/hamburger.svg
  SvgGenImage get hamburger => const SvgGenImage('assets/icons/hamburger.svg');

  /// File path: assets/icons/more.svg
  SvgGenImage get more => const SvgGenImage('assets/icons/more.svg');

  /// File path: assets/icons/savings.svg
  SvgGenImage get savings => const SvgGenImage('assets/icons/savings.svg');

  /// File path: assets/icons/shopping.svg
  SvgGenImage get shopping => const SvgGenImage('assets/icons/shopping.svg');

  /// File path: assets/icons/wallet.svg
  SvgGenImage get wallet => const SvgGenImage('assets/icons/wallet.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        addPlus,
        arrowUpRight,
        bankingfee,
        barcode,
        bellNotification,
        billpay,
        deposit,
        donations,
        ewallet,
        hamburger,
        more,
        savings,
        shopping,
        wallet
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/app_logo.png');

  /// File path: assets/images/card_bg.png
  AssetGenImage get cardBg => const AssetGenImage('assets/images/card_bg.png');

  /// File path: assets/images/mastercard.png
  AssetGenImage get mastercard =>
      const AssetGenImage('assets/images/mastercard.png');

  /// List of all assets
  List<AssetGenImage> get values => [appLogo, cardBg, mastercard];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsFontGen font = $AssetsFontGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
