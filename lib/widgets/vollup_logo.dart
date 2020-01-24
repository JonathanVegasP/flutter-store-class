import 'package:flutter/material.dart';
import 'package:flutter_store/resources/images.dart';

class VollupLogo extends StatelessWidget {
  final double width;
  final double height;

  const VollupLogo({Key key, this.width = 100, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      VollupImage,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
