import 'package:flutter/material.dart';
import 'package:flutter_store/resources/images.dart';

class LogoWidget extends StatelessWidget {
  final double width;
  final double height;

  const LogoWidget({Key key, this.width = 250, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      LogoImage,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}

