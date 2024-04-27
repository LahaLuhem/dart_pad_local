// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'const_values.dart';

/// Wrapper for all Icons, [Svg]s, local Json files and other assets.
abstract class ConstMedia {
  // SVGs
  static const dart_logo = 'assets/logos/dart_logo.svg';

  // PNGs

  // JSONs

  // Fonts

  static SvgPicture buildIcon(
    String iconReference, {
    double? width,
    double? height,
    Clip clipBehavior = Clip.hardEdge,
  }) =>
      SvgPicture.asset(
        iconReference,
        width: width,
        height: height,
        fit: BoxFit.fitWidth,
        clipBehavior: clipBehavior,
      );

  ///Builds an [ImageProvider] of respective type, given the [urlPath].
  static ImageProvider imageFromProviderPath({required String urlPath}) {
    final uri = Uri.parse(urlPath);
    if (uri.isScheme('https')) return NetworkImage(urlPath);
    return AssetImage(uri.toString());
  }
}
