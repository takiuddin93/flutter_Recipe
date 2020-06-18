import 'package:flutter/material.dart';

class DashboardTopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width * 0, size.height * 0.138);
    path.quadraticBezierTo(size.width * 0.001, size.height * 0.170,
        size.width * 0.064, size.height * 0.170);
    path.lineTo(size.width * 0.936, size.height * 0.170);
    path.quadraticBezierTo(size.width * 0.999, size.height * 0.170, size.width,
        size.height * 0.138);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
