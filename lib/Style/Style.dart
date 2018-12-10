import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pigments {
  const Pigments();

  static const Color loginGradientStart = const Color.fromRGBO(234, 44, 109, 1);
  static const Color loginGradientEnd = const Color.fromRGBO(100, 0, 400, 1);

  static const Color Gradient1Start = const Color.fromRGBO(250, 0, 139, 1);
  static const Color Gradient1End = const Color.fromRGBO(50, 5, 100, 1);

  static const Color Gradient2Start = const Color.fromRGBO(200, 0, 200, 1);
  static const Color Gradient2End = const Color.fromRGBO(0, 0, 400, 1);

  static const Color Gradient3Start = const Color.fromRGBO(500, 100, 0, 1);
  static const Color Gradient3End = const Color.fromRGBO(400, 0, 100, 1);

  static const Color Gradient4Start = const Color.fromRGBO(0, 200, 500, 1);
  static const Color Gradient4End = const Color.fromRGBO(20, 0, 400, 1);

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
  static final TextStyle T1 = TextStyle(
      fontFamily: Fonts.ralewayFont, fontWeight: FontWeight.w700, fontSize: 18);

  static final TextStyle S1 =
      TextStyle(fontFamily: Fonts.ralewayFont, fontSize: 15);

  static final TextStyle S2 = TextStyle(
      fontFamily: Fonts.ralewayFont,
      fontSize: 10,
      letterSpacing: 3,
      fontWeight: FontWeight.bold);

  static final TextStyle S3 = TextStyle(
      fontFamily: Fonts.ralewayFont,
      fontSize: 10,
      // letterSpacing: 3,
      fontWeight: FontWeight.bold);

  static final TextStyle N1 = TextStyle(
      fontSize: 20,
      color: Colors.purple,
      fontFamily: Fonts.quickBoldFont,
      fontWeight: FontWeight.w800);

  static final TextStyle N2 = TextStyle(
      color: Colors.white70,
      fontFamily: Fonts.quickBoldFont,
      fontSize: 15,
      fontWeight: FontWeight.w700);

  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";
}

class FadePageRoute<T> extends MaterialPageRoute<T> {
  FadePageRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class Shapes {
  static RoundedRectangleBorder DefaultCardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  );
}
