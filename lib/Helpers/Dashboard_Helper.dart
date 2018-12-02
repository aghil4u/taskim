import 'package:flutter/material.dart';
import 'package:task.im/Style/Style.dart' as Theme;

class DashboardMenuRow extends StatelessWidget {
  final firstLabel;
  final IconData firstIcon;
  final firstIconCircleColor;
  final secondLabel;
  final IconData secondIcon;
  final secondIconCircleColor;
  final thirdLabel;
  final IconData thirdIcon;
  final thirdIconCircleColor;
  final fourthLabel;
  final IconData fourthIcon;
  final fourthIconCircleColor;

  const DashboardMenuRow(
      {Key key,
      this.firstLabel,
      this.firstIcon,
      this.firstIconCircleColor,
      this.secondLabel,
      this.secondIcon,
      this.secondIconCircleColor,
      this.thirdLabel,
      this.thirdIcon,
      this.thirdIconCircleColor,
      this.fourthLabel,
      this.fourthIcon,
      this.fourthIconCircleColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          LabelBelowIcon(
            icon: firstIcon,
            label: firstLabel,
            circleColor: firstIconCircleColor,
          ),
          LabelBelowIcon(
            icon: secondIcon,
            label: secondLabel,
            circleColor: secondIconCircleColor,
          ),
          LabelBelowIcon(
            icon: thirdIcon,
            label: thirdLabel,
            circleColor: thirdIconCircleColor,
          ),
          LabelBelowIcon(
            icon: fourthIcon,
            label: fourthLabel,
            circleColor: fourthIconCircleColor,
          ),
        ],
      ),
    );
  }
}

class LabelBelowIcon extends StatelessWidget {
  final label;
  final IconData icon;
  final iconColor;
  final onPressed;
  final circleColor;
  final isCircleEnabled;
  final betweenHeight;

  LabelBelowIcon(
      {this.label,
      this.icon,
      this.onPressed,
      this.iconColor = Colors.white,
      this.circleColor,
      this.isCircleEnabled = true,
      this.betweenHeight = 5.0});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          isCircleEnabled
              ? CircleAvatar(
                  backgroundColor: circleColor,
                  radius: 20.0,
                  child: Icon(
                    icon,
                    size: 12.0,
                    color: iconColor,
                  ),
                )
              : Icon(
                  icon,
                  size: 23.0,
                  color: iconColor,
                ),
          SizedBox(
            height: betweenHeight,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: Theme.Fonts.ralewayFont,
                fontSize: 11,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class DashboardBackground extends StatelessWidget {
  final showIcon;
  final image;

  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    // Colors.blueGrey.shade800,
    // Colors.black87,
    Theme.Pigments.loginGradientStart,
    Theme.Pigments.loginGradientEnd,
  ];

  DashboardBackground({this.showIcon = true, this.image});

  Widget topHalf(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return new Flexible(
      flex: 2,
      child: ClipPath(
        clipper: new ArcClipper(),
        child: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                end: AlignmentDirectional(0, 2),
                colors: kitGradients,
              )),
            ),
            showIcon
                ? new Center(
                    child: SizedBox(
                        height: deviceSize.height / 8,
                        width: deviceSize.width / 2,
                        child: FlutterLogo(
                          colors: Colors.yellow,
                        )),
                  )
                : new Container(
                    width: double.infinity,
                    child: image != null
                        ? Image.network(
                            image,
                            fit: BoxFit.cover,
                          )
                        : new Container())
          ],
        ),
      ),
    );
  }

  final bottomHalf = new Flexible(
    flex: 3,
    child: new Container(),
  );

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[topHalf(context), bottomHalf],
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = new Offset(size.width / 4, size.height);
    var firstPoint = new Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint =
        new Offset(size.width - (size.width / 4), size.height);
    var secondPoint = new Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DashboardTitle extends StatelessWidget {
  final title;
  final textColor;
  DashboardTitle({this.title, this.textColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w700, color: textColor),
        ),
      ],
    );
  }
}
