import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageUtil {
  static Widget load(
    String? url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    Widget? placeholder,
    Widget? errorWidget,
    Color? color,
  }) {
    final image = CachedNetworkImage(
      imageUrl: url ?? '',
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, _) =>
          placeholder ??
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      errorWidget: (context, _, _) =>
          errorWidget ?? const Icon(Icons.broken_image),
      color: color,
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius, child: image);
    }

    return image;
  }
}
