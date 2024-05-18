import 'package:flutter/material.dart';
import 'package:helmy_project/resources/colors_manager.dart';

class BuildFavouriteIcon extends StatelessWidget {
  final dynamic onTap;
  final bool isFilledIcon;
  const BuildFavouriteIcon({super.key,required this.onTap,required this.isFilledIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
            onTap: onTap,
            child: Icon(
             isFilledIcon?  Icons.favorite: Icons.favorite_border_rounded ,
              color: ColorsManager.greyText,
            ) );
  }
}