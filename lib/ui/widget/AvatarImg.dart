import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/constant/AssetsConstant.dart';

class AvatarImg extends StatelessWidget {
  double radius;
  String placeHolder = ic_user_avatar_default;
  String url;

  AvatarImg(this.url,
      {this.radius = 30, this.placeHolder = ic_user_avatar_default});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius, backgroundImage: CachedNetworkImageProvider(url));
  }
}
