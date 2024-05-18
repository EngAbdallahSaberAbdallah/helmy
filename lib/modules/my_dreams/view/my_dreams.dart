import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:helmy_project/app/components.dart';
import 'package:helmy_project/modules/home/widgets/build_circle_image.dart';
import 'package:helmy_project/modules/home/widgets/build_country_flag.dart';
import 'package:helmy_project/modules/home/widgets/build_order_description_text.dart';
import 'package:helmy_project/modules/home/widgets/build_order_status.dart';
import 'package:helmy_project/modules/home/widgets/build_user_name_text.dart';
import 'package:helmy_project/modules/my_dreams/cubit/cubit/my_dreams_cubit.dart';
import 'package:helmy_project/modules/my_dreams/shimmer/my_dreams_shimmer.dart';
import 'package:helmy_project/modules/tafsser/model/dream_detail.dart';
import 'package:helmy_project/modules/tafsser/view/tafsser_detail.dart';
import 'package:helmy_project/network/network_constants.dart';
import 'package:helmy_project/resources/assets_manager.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/strings_manager.dart';

class MyDreams extends StatefulWidget {
  MyDreams({super.key});

  @override
  State<MyDreams> createState() => _MyDreamsState();
}

class _MyDreamsState extends State<MyDreams> {
  int currentPage = 1;

  late List<DreamDetail> dreams = [];

  final scrollController = ScrollController();

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<MyDreamsCubit>(context).getAllDreams();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (NetworkConstants.token.isNotEmpty) {
      setupScrollController();
      BlocProvider.of<MyDreamsCubit>(context).page = 1;
      BlocProvider.of<MyDreamsCubit>(context).getAllDreams();
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // RefreshIndicator(
        //     color: ColorsManager.primaryDarkPurple,
        //     onRefresh: () async {
        //       return context.read<MyDreamsCubit>().getAllDreams();
        //     },
        //     child:

        NetworkConstants.token.isNotEmpty
            ? _buildListOfOrders()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    child: const LoginFirst()),
              );
  }

  Widget _buildListOfOrders() {
    return BlocBuilder<MyDreamsCubit, MyDreamsState>(builder: (context, state) {
      if (state is MyDreamLoading && state.isFirstFetch) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2 - 149.h),
            child: const CircularProgressIndicator(),
          ),
        );
        // _loadingShimmer();
      }

      bool isLoading = false;

      if (state is MyDreamLoading) {
        dreams = state.oldMyDreams;
        isLoading = true;
      } else if (state is MyDreamsLoaded) {
        dreams = state.dreams;
      }

      // } else if (state is MyDreamsLoaded) {
      return dreams.length > 0
          ? Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.only(bottom: 20, top: 0),
                  itemCount: dreams.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < dreams.length) {
                      return _buildCard(dreamDetail: dreams[index]);
                    } else {
                      Timer(const Duration(milliseconds: 30), () {
                        scrollController
                            .jumpTo(scrollController.position.maxScrollExtent);
                      });
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 2 -
                                  149.h),
                          child: const CircularProgressIndicator(),
                        ),
                      );
                    }
                  }))
          : Transform.translate(
              offset: const Offset(0, 100), child:CenterEmptyHelm(
                title:tr( StringsManager.noDreamsAdded,)
              )
              // const CustomEmptyScreen(url: AssetsManager.emptyOrderScreen)
              );
      // } else if (state is MyDreamsError) {
      //   return Center(child: state.exceptionWidget);
      // } else {
      //   return Container();
      // }
    });
  }

  _buildCard({required DreamDetail dreamDetail}) {
    return InkWell(
      onTap: () {
        Get.to(() => TafsserDetail(
              dreamId: dreamDetail.id.toString(),
              canAddDream: dreamDetail.dreamComments!.length > 0 &&
                      dreamDetail.status != "finished"
                  ? true
                  : false,
              isFromFavourite: false,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.5, vertical: 11),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: ColorsManager.cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BuildCircleImage(
                    imgPath: AssetsManager.accountImage, width: 80, height: 80),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: 25,
                  width: 33.33,
                  child: BuildCountryFlag(
                      countryCode:
                          dreamDetail.country!.flag.toString().toUpperCase()),
                ),
              ],
            ),
            SizedBox(
              width: 10.h,
            ),
            Expanded(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildOrderStatus(
                        status: dreamDetail.plan!.name!.ar.toString()),
                    BuildUserNameText(userName: dreamDetail.title.toString()),
                    BuildOrderDescriptionText(
                        description: dreamDetail.description.toString()),
                    // const SizedBox(
                    //   height: 10.5,
                    // ),
                    //  BuildTimeTextWithIcon(time: 'منذ 3 ساعات '),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _loadingShimmer() {
    return Expanded(
        child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => const MyDreamsShimmer(),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 25,
                ),
            itemCount: 10));
  }
}
