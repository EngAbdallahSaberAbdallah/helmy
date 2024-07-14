import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helmy_project/resources/assets_manager.dart';

class BuildCircleImage extends StatelessWidget {
  final String imgPath;

  final double width;
  final double height;
  const BuildCircleImage(
      {super.key,
      required this.imgPath,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey, // Placeholder color if no image or SVG
      ),
      child: ClipOval(
        child: Stack(
          children: [
            if (imgPath.isNotEmpty)
              Image.network(
                imgPath,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            if (imgPath.isEmpty)
              SvgPicture.asset(
                AssetsManager.accountImage,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}
