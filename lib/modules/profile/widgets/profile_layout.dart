import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../controllers/profile_controller.dart';
import '../cubit/profile_cubit.dart';
import '../../../network/network_constants.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../app/components.dart';
import '../../auth/widgets/build_header_image.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/styles_manager.dart';
import 'package:get/get.dart';

class ProfileLayout extends StatefulWidget {
  final Widget child;
  const ProfileLayout({super.key, required this.child});

  @override
  State<ProfileLayout> createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  
  late String images = '';
  late String? userName = '';
  late int? userCountryId = 0;

   final ProfileController profileController = Get.find();

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    
    userName = await getIt.get<CacheHelper>().getName() ?? "";
    userCountryId = await getIt.get<CacheHelper>().getAreaId() ?? 0;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarChangedWidget(
        statusBarColor: ColorsManager.trans,
        widget: Scaffold(
          backgroundColor: ColorsManager.primaryLightPurple,
          body: NetworkConstants.token.isNotEmpty
              ? _buildBody()
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  child: const Center(child: LoginFirst()),
                ),
        ));
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Align(alignment: Alignment.topCenter, child: _buildHeaderImage()),
        Align(alignment: Alignment.topCenter, child: _headerAppBar()),
        Align(alignment: Alignment.topCenter, child: _buildAvatarProfile()),
      ],
    );
    // });
  }

  Widget _headerAppBar() {
    return Transform.translate(
      offset: Offset(0, 48.h),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              tr(StringsManager.account),
              style: getRegularStyle(
                  color: ColorsManager.primaryLightPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
            InkWell(
              onTap: () {
                Get.offAllNamed(HelmyRoutes.userStartRoute);
              },
              child: Container(
                width: 42.w,
                height: 42.h,
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsManager.primaryLightPurple,
                ),
                child: const Icon(
                  Icons.home_outlined,
                  color: ColorsManager.primaryDarkPurple,
                  size: 29,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo({required String title}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,
            style: getRegularStyle(
              color: ColorsManager.primaryDarkPurple,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ))
      ],
    );
  }

  Widget _buildHeaderImage() {
    return SizedBox(
      height: 277.h,
      child:
          BuildHeaderImage(imgPath: AssetsManager.profileUser, height: 277.sp),
    );
  }

  Widget _buildAvatarProfile() {
    return Transform.translate(
        offset: Offset(0, 205.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<File?>(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const ImagePickerWidget(),
                      ).then(
                        (image) {
                          if (image != null) {
                            setState(() {
                              images = image.path;
                            });
                            // Call updateProfile in ProfileCubit after setting the image
                            context.read<ProfileCubit>().updateProfile(
                                imagePath: image.path,
                                name: userName!,
                                countryId: userCountryId!);
                          }
                        },
                      );
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorsManager.primaryDarkPurple
                                .withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: images == "" && profileController.profileImage.value != ''
                              ?Obx(() =>  Image.network(
                                  width: 120,
                                  height: 120,
                                  profileController.profileImage.value,
                                  fit: BoxFit.cover,
                                ))
                              : images != ""
                                  ? Image.file(
                                      File(images),
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : SvgPicture.asset(
                                      width: 120,
                                      height: 120,
                                      AssetsManager.accountImage,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Transform.translate(
                        offset: const Offset(-3, -3),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet<File?>(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (_) => const ImagePickerWidget(),
                            ).then(
                              (image) => setState(() {
                                if (image != null) {
                                  // images.add(image.path);
                                  // imagesNetwork = image.path;
                                  context
                                      .read<ProfileCubit>()
                                      .updateProfile(
                                imagePath: image.path,
                                name: userName!,
                                countryId: userCountryId!);
                                }
                              }),
                            );
                          },
                          child: Container(
                              width: 22,
                              height: 22,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorsManager.buttonDarkColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Icon(
                                Icons.add,
                                color: ColorsManager.primaryBgDark,
                                size: 18,
                              )),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            _buildUserInfo(title: userName!),
            SizedBox(
              height: 28.sp,
            ),
            widget.child
          ],
        ));
  }
}
