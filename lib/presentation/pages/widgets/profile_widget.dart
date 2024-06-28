import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

profileWidget({String? imageUrl}) {
  if (imageUrl == null || imageUrl == '') {
    return Image.asset(
      'assets/profile__default.png',
      fit: BoxFit.cover,
    );
  } else {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return const Center(child: CircularProgressIndicator());
      },
      errorWidget: (context, url, error) {
        return Image.asset(
          'assets/profile_default.png',
          fit: BoxFit.cover,
        );
      },
    );
  }
}
