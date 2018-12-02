import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pigments {
  const Pigments();

  static const Color loginGradientStart = const Color.fromRGBO(234, 44, 109, 1);
  static const Color loginGradientEnd = const Color.fromRGBO(100, 0, 400, 1);

  static const Color Gradient2Start = const Color.fromRGBO(200, 0, 200, 1);
  static const Color Gradient2End = const Color.fromRGBO(0, 0, 400, 1);

  static const Color PrimaryColor = const Color.fromRGBO(100, 0, 400, 1);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static List<Color> kitGradients = [loginGradientStart, loginGradientEnd];
}

class Format {
  static final DateFormat StandardDateFormat = DateFormat('dd/MM/yy');
  static final DateFormat StandardDateAndTimeFormat =
      DateFormat('dd/MM/yy hh:mm aaa');
}

class Fonts {
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";
}
