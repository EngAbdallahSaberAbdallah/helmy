import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildCircleImage extends StatelessWidget {
  final String imgPath;
  final double width;
  final double height;
  const BuildCircleImage({super.key, required this.imgPath, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircleAvatar(
        child: SvgPicture.asset(
          imgPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}