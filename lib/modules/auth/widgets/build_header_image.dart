import 'package:flutter/material.dart';

class BuildHeaderImage extends StatelessWidget {
  final String imgPath;
  final double height;
  const BuildHeaderImage({super.key,required this.imgPath, required this.height});

  @override
  Widget build(BuildContext context) {
    return  Image.asset(
      imgPath,
      width: MediaQuery.of(context).size.width,
      height: height,
      fit: BoxFit.fill,
    );
  }
}
