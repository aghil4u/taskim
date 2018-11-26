import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {
  const Colors();

  static const Color loginGradientStart = const Color.fromRGBO(234, 44, 109, 1);

  static const Color loginGradientEnd = const Color.fromRGBO(100, 0, 400, 1);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
