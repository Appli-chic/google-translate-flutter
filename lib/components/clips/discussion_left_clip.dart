import 'package:flutter/material.dart';

class DiscussionLeftClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0.0);

    path.arcToPoint(
      Offset(size.width, size.height),
      clockwise: false,
      radius: Radius.elliptical(70, 60),
    );

    path.lineTo(0.0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}