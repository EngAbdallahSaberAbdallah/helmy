import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../tafsser/model/dream_detail.dart';
import '../../../app/components.dart';
import '../cubit/cubit/favourite_cubit/favourites_cubit.dart';
import '../model/favourite_model.dart';
import '../../home/widgets/build_circle_image.dart';
import '../../home/widgets/build_country_flag.dart';
import '../../home/widgets/build_order_description_text.dart';
import '../../home/widgets/build_order_status.dart';
import '../../home/widgets/build_user_name_text.dart';
import '../../tafsser/view/tafsser_detail.dart';
import '../../../network/network_constants.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  int currentPage = 1;

  late List<FavouriteModel> dreams = [];

  final scrollController = ScrollController();

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<FavouritesCubit>(context).getFavouriteDreams();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (NetworkConstants.token.isNotEmpty) {
      setupScrollController();
      BlocProvider.of<FavouritesCubit>(context).page = 1;
      BlocProvider.of<FavouritesCubit>(context).getFavouriteDreams();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NetworkConstants.token.isNotEmpty
        ? _buildListOfOrders()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: const LoginFirst()),
          );
  }

  // Widget _buildListOfOrders() {
  Widget _buildListOfOrders() {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
      if (state is FavouritesLoading && state.isFirstFetch) {
        return _centerLoading();
        // _loadingShimmer();
      }

      bool isLoading = false;

      if (state is FavouritesLoading) {
        dreams = state.oldMyDreams;
        isLoading = true;
      } else if (state is FavouritesLoaded) {
        dreams = state.favouriteModel;
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
                      return _buildCard(favouriteModel: dreams[index]);
                    } else {
                      Timer(const Duration(milliseconds: 30), () {
                        scrollController
                            .jumpTo(scrollController.position.maxScrollExtent);
                      });
                      return _centerLoading();
                    }
                  }))
          : Transform.translate(
              offset: const Offset(0, 100),
              child: CenterEmptyHelm(
                  title: tr(
                StringsManager.noFavouriteDreams,
              )));
      // } else if (state is MyDreamsError) {
      //   return Center(child: state.exceptionWidget);
      // } else {
      //   return Container();
      // }
    });
  }

  _centerLoading() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 2 - 149.h),
        child: const Loading(),
      ),
    );
  }

  _buildCard({required FavouriteModel favouriteModel}) {
    return InkWell(
      onTap: () {
        Get.to(() => TafsserDetail(
              dreamDetail: DreamDetail.fromJson(favouriteModel.dream!.toJson()),
              dreamId: favouriteModel.dreamId.toString(),
              canAddDream: false,
              isFromFavourite: true,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.5, vertical: 11),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: ColorsManager.cardColor,
            // color: ColorsManager.primaryLightPurple,
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
                BuildCircleImage(
                    imgPath: favouriteModel.user!.avatarUrl ?? "",
                    width: 80,
                    height: 80),
                const SizedBox(
                  height: 18,
                ),
                BuildCountryFlag(
                  countryCode: favouriteModel.dream!.country!.flag.toString(),
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    BuildOrderStatus(
                        status:
                            favouriteModel.dream!.plan!.name!.ar.toString()),
                    // BuildFavouriteIcon(
                    //     onTap: () {
                    //       context.read<FavouritesCubit>().deleteFavouriteDream(
                    //           dreamId: favouriteModel.dreamId.toString(),

                    //           context: context);
                    //     },
                    //     isFilledIcon: false)
                    //   ],
                    // ),
                    BuildUserNameText(
                        userName: favouriteModel.dream!.title.toString()),
                    BuildOrderDescriptionText(
                        description:
                            favouriteModel.dream!.description.toString()),
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
