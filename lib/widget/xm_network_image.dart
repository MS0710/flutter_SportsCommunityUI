import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/screen.dart';

xmNetWorkImage(String url, double width,
    {double? height, String placeholdlerImgNm = 'icon'}) {
  return CachedNetworkImage(
    width: xmDp(width),
    height: null != height ? xmDp(height) : xmDp(width),
    imageUrl: url,
    fit: BoxFit.cover,
    placeholder: (context, url) {
      return Image(
          width: xmDp(width),
          height: null != height ? xmDp(height) : xmDp(width),
          image: AssetImage('assets/images/$placeholdlerImgNm.png'));
    },
  );
}