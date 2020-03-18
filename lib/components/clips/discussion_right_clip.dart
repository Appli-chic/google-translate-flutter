import 'package:flutter/material.dart';

class DiscussionRightClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);

    path.arcToPoint(
      Offset(0.0, 0.0),
      clockwise: false,
      radius: Radius.elliptical(70, 60),
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}