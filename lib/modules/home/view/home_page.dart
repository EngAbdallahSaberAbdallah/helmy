import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/components.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../../favourite/cubit/cubit/home_cubit/cubit/home_cubit.dart';
import '../widgets/build_circle_image.dart';
import '../widgets/build_country_flag.dart';
import '../widgets/build_order_description_text.dart';
import '../widgets/build_order_status.dart';
import '../widgets/build_user_name_text.dart';
import '../../tafsser/model/dream_detail.dart';
import '../../tafsser/view/tafsser_detail.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import 'package:get/get.dart';
import '../../../resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  final bool isFromInterpreter;
  const HomePage({super.key, required this.isFromInterpreter});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;

  late List<DreamDetail> dreams = [];

  final scrollController = ScrollController();

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<HomeCubit>(context)
              .getAllDreams(isFromInterpreter: widget.isFromInterpreter);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupScrollController();
    BlocProvider.of<HomeCubit>(context).page = 1;
    BlocProvider.of<HomeCubit>(context)
        .getAllDreams(isFromInterpreter: widget.isFromInterpreter);
  }

  @override
  Widget build(BuildContext context) {
    return _buildListOfOrders();
  }

  Widget _buildListOfOrders() {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomeLoading && state.isFirstFetch) {
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

      if (state is HomeLoading) {
        dreams = state.oldMyDreams;
        isLoading = true;
      } else if (state is HomeLoaded) {
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
              offset: const Offset(0, 100),
              child: CenterEmptyHelm(
                  title: tr(
                      // NetworkConstants.isInterpreter?
                      StringsManager.noDreams
                      // :StringsManager.noDreamsAdded ,
                      ))
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
      onTap: () async {
        final bool isInterpreter =
            await getIt.get<CacheHelper>().getIsInterpreter() ?? false;
        Get.to(() => TafsserDetail(
              dreamDetail: dreamDetail,
              dreamId: dreamDetail.id.toString(),
              canAddDream: isInterpreter,
              isFromFavourite: false,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.5, vertical: 11),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: ColorsManager.cardColor,
            // color: ColorsManager.white,
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
                BuildCountryFlag(
                  countryCode: dreamDetail.country!.flag!,
                ),
              ],
            ),
            const SizedBox(
              width: 10,
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
}
