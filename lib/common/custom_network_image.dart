import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/common/assets.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (context, url) => Image.asset(
        Assets.placeholderImage,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
      errorWidget: (context, url, error) => Image.asset(
        Assets.placeholderImage,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}
