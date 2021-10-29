import 'package:flutter/material.dart';

Color colorPageBackground = Colors.grey.shade100;
Color colorGradientStart = Color(0xFFFF9C5B);
Color colorGradientEnd = Color(0xFFFAD08B);

LinearGradient pageGradient = LinearGradient(
  colors: [
    colorGradientStart,
    colorGradientEnd,
    Colors.grey.shade100,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
