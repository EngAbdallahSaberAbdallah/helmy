import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helmy_project/helpers/cache_helper.dart';
import 'package:helmy_project/helpers/getx_controllers.dart';
import 'package:helmy_project/helpers/services_locator.dart';
import 'package:helmy_project/resources/assets_manager.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late double globalFontSize = 15.0, globalContainerWidth = 30.0;

  @override
  void initState() {
    super.initState();
    _getFontSizeAndContainerWidth();
  }

  _getFontSizeAndContainerWidth() async {
    globalContainerWidth =
        await getIt.get<CacheHelper>().getFontSizeForContainer();
    globalFontSize = await getIt.get<CacheHelper>().getFontSize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(headerTitle: tr(StringsManager.changeFontSize)),
          SizedBox(
            height: 22.h,
          ),
          _buildChooseFontSize(),
          SizedBox(
            height: 25.h,
          ),
          _buildContainerLine(),
          SizedBox(
            height: 28.h,
          ),
          _buildHeader(headerTitle: tr(StringsManager.reviewFontSize)),
          SizedBox(
            height: 12.h,
          ),
          _buildDynamicFontText(
            title: tr(StringsManager.simpleText),
          )
        ],
      ),
    );
  }

  _buildContainerLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 56),
      child: Image.asset(AssetsManager.line),
    );
  }

  Widget _buildChooseFontSize() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRowOfContainers(),
        ]);
  }

  _buildRowOfContainers() {
    return SizedBox(
      height: 79.h,
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, 22),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: double.infinity,
              height: 9,
              color: ColorsManager.buttonDarkColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildFontContainerSize(
                  containerWidth: 30,
                  color: globalContainerWidth == 30
                      ? ColorsManager.primaryDarkPurple
                      : ColorsManager.buttonDarkColor,
                  fontText: tr(StringsManager.small)),
              _buildFontContainerSize(
                  containerWidth: 40,
                  color: globalContainerWidth == 40
                      ? ColorsManager.primaryDarkPurple
                      : ColorsManager.buttonDarkColor,
                  fontText: tr(StringsManager.medium)),
              _buildFontContainerSize(
                  containerWidth: 50,
                  color: globalContainerWidth == 50
                      ? ColorsManager.primaryDarkPurple
                      : ColorsManager.buttonDarkColor,
                  fontText: tr(StringsManager.large)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFontContainerSize(
      {required double containerWidth,
      required Color color,
      required String fontText}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              getIt.get<CacheHelper>().setFontSize(
                  fontSize: containerWidth == 30
                      ? 15
                      : containerWidth == 40
                          ? 18
                          : 22);
              getIt
                  .get<CacheHelper>()
                  .setFontSizeForContainer(containerWidth: containerWidth);

              globalContainerWidth = containerWidth;
              globalFontSize = containerWidth == 30
                  ? 15
                  : containerWidth == 40
                      ? 18
                      : 22;

              GetXControllers.fontSizeController.updateFontSize(
                fontSize22: containerWidth == 30
                    ? 22
                    : containerWidth == 40
                        ? 24
                        : 26,
                fontSize20: containerWidth == 30
                    ? 20
                    : containerWidth == 40
                        ? 22
                        : 24,
                fontSize18: containerWidth == 30
                    ? 18
                    : containerWidth == 40
                        ? 20
                        : 22,
                fontSize16: containerWidth == 30
                    ? 16
                    : containerWidth == 40
                        ? 18
                        : 20,
                fontSize15: containerWidth == 30
                    ? 15
                    : containerWidth == 40
                        ? 17
                        : 18,
                fontSize14: containerWidth == 30
                    ? 14
                    : containerWidth == 40
                        ? 16
                        : 18,
                fontSize13: containerWidth == 30
                    ? 13
                    : containerWidth == 40
                        ? 16
                        : 18,
                fontSize12: containerWidth == 30
                    ? 12
                    : containerWidth == 40
                        ? 14
                        : 16,
                fontSize10: containerWidth == 30
                    ? 10
                    : containerWidth == 40
                        ? 12
                        : 14,
              );
            });
          },
          child: Container(
            width: containerWidth,
            height: containerWidth,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _buildSubTitle(subTitle: fontText, color: color),
      ],
    );
  }

  _buildHeader({required String headerTitle}) {
    return Text(
      headerTitle,
      style: Theme.of(context).textTheme.titleLarge
    );
  }

  _buildSubTitle({required String subTitle, required Color color}) {
    return Text(
      subTitle,
      style: getRegularStyle(color: color),
    );
  }

  _buildDynamicFontText({required String title}) {
    return Text(
      title,
      style: getRegularStyle(
          color: ColorsManager.primaryDarkPurple, fontSize: globalFontSize),
    );
  }
}
