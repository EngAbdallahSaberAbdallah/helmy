import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  final String imgPath;
  const HeaderImage({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imgPath,
      width: MediaQuery.of(context).size.width,
      height: 277,
    );
  }
}
