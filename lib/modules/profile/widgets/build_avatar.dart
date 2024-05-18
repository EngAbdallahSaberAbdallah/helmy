import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';

class BuildAvatar extends StatelessWidget {
  final double height;
  final double width;
  final String imgPath;
  final bool isFile;
  const BuildAvatar(
      {super.key,
      required this.height,
      required this.width,
      required this.imgPath,
      required this.isFile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          color: ColorsManager.borderGrey, shape: BoxShape.circle),
      child: ClipOval(
          child: imgPath == null || imgPath.isEmpty || imgPath == ""
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: SvgPicture.asset(
                    AssetsManager.accountImage,
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                )
              : isFile
                  ? Image.file(File(imgPath), fit: BoxFit.cover)
                  : Image.network(
                      imgPath,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorsManager.primaryDarkPurple,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )),
    );
  }
}
