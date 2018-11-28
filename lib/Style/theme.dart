import 'dart:ui';
import 'package:flutter/material.dart';

class Colors {
  const Colors();

  static const Color loginGradientStart = const Color.fromRGBO(234, 44, 109, 1);

  static const Color loginGradientEnd = const Color.fromRGBO(100, 0, 400, 1);

  static const Color PrimaryColor = const Color.fromRGBO(100, 0, 400, 1);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}

class Fonts {
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";
}
