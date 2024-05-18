import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:helmy_project/app/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:helmy_project/app/functions.dart';
import 'package:helmy_project/modules/dream/controller/dream_controller.dart';
import 'package:helmy_project/modules/dream/widget/recorder_widget.dart';
import 'package:helmy_project/modules/favourite/cubit/cubit/favourite_cubit/favourites_cubit.dart';
import 'package:helmy_project/modules/favourite/view/widget/favourite_icon.dart';
import 'package:helmy_project/modules/home/widgets/build_circle_image.dart';
import 'package:helmy_project/modules/home/widgets/build_country_flag.dart';
import 'package:helmy_project/modules/home/widgets/build_order_description_text.dart';
import 'package:helmy_project/modules/home/widgets/build_order_status.dart';
import 'package:helmy_project/modules/home/widgets/build_time_text_with_icon.dart';
import 'package:helmy_project/modules/home/widgets/build_user_name_text.dart';
import 'package:helmy_project/modules/my_dreams/cubit/cubit/my_dreams_cubit.dart';
import 'package:helmy_project/modules/tafsser/bloc/bloc/tafsser_bloc.dart';
import 'package:helmy_project/modules/tafsser/model/dream_detail.dart';
import 'package:helmy_project/modules/tafsser/widget/audio_player.dart';
import 'package:helmy_project/resources/assets_manager.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';

class TafsserDetail extends StatefulWidget {
  final String dreamId;
  final bool canAddDream;
  final bool isFromFavourite;
  const TafsserDetail(
      {super.key, required this.dreamId, required this.canAddDream, required this.isFromFavourite});

  @override
  State<TafsserDetail> createState() => _TafsserDetailState();
}

class _TafsserDetailState extends State<TafsserDetail> {
  final TextEditingController commentController = TextEditingController();

  final DreamController dreamController = Get.find<DreamController>();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<TafsserBloc>().add(GetSingleDream(dreamId: widget.dreamId));

    return StatusBarChangedWidget(
        statusBarColor: ColorsManager.trans,
        widget: Scaffold(
          floatingActionButton: widget.canAddDream
              ? InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: Stack(
                          children: [
                            Container(
                              height: 447.h,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 32),
                              decoration: BoxDecoration(
                                  color: ColorsManager.buttonDarkColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 202.h,
                                    child: CustomTextAreaFormField(
                                        controller: commentController,
                                        hint: 'اكتب تعليقك هنا ....',
                                        onChanged: (value) {},
                                        sufixIconBackground:
                                            ColorsManager.primaryDarkPurple,
                                        borderColor: Colors.white,
                                        heightOfTextFormField: 202),
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  const RecorderExample(),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  SizedBox(
                                      height: 44.h,
                                      width: 154,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorsManager.primaryDarkPurple,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        onPressed: () {
                                          context
                                              .read<MyDreamsCubit>()
                                              .addDreamComment(
                                                  dreamId: widget.dreamId,
                                                  content:
                                                      commentController.text,
                                                  voiceRecord: dreamController
                                                              .voiceRecord
                                                              .value !=
                                                          ""
                                                      ? File(dreamController
                                                          .voiceRecord.value)
                                                      : File(''));
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const CustomCircleProgressIndicator());
                                          Future.delayed(
                                              const Duration(seconds: 2), () {
                                            commentController.text = '';
                                            dreamController.voiceRecord.value =
                                                '';
                                            context.read<TafsserBloc>().add(
                                                GetSingleDream(
                                                    dreamId: widget.dreamId));
                                            Get.back();
                                            Get.back();
                                          });
                                        },
                                        child: Text(
                                          tr(StringsManager.send),
                                          style: getRegularStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Transform.translate(
                                offset: const Offset(6, -6),
                                child: const CustomClosedButton())
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 70.h,
                    width: 175.w,
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                        color: ColorsManager.primaryDarkPurple,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.chat,
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          // tr(StringsManager.addComment),
                          'أضف تعليق',
                          style: getRegularStyle(color: ColorsManager.white),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          body: Align(
            alignment: Alignment.topCenter,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                      onTapBackBtn: () {
                        Get.back();
                      },
                      title: tr(StringsManager.interpretationDream),
                      widget: const SizedBox(
                        width: 50,
                      )),
                  SizedBox(
                    height: 20.h,
                  ),

                  // SizedBox(
                  //       height: MediaQuery.of(context).size.height - 183.h,
                  //       child:
                  _buildListOfOrders(),
                  //  ),
                ]),
          ),
        ));
  }

  Widget _buildDreamDetail({required DreamDetail dreamDetail}) {
    return Container(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BuildOrderStatus(
                          status: dreamDetail.plan!.name!.ar.toString()),
                    !widget.isFromFavourite?  BuildFavouriteIcon(
                          onTap: () {
                            context.read<FavouritesCubit>().addFavouiteDream(
                                dreamId: dreamDetail.id.toString(),
                                rating: 0,
                                context: context);
                          },
                          isFilledIcon: false): const SizedBox.shrink()
                    ],
                  ),
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
    );
  }

  Widget _buildListOfOrders() {
    return BlocBuilder<TafsserBloc, DreamState>(builder: (context, state) {
      if (state is DreamLoading) {
        return Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 2 - 183.h),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is SignleDreamLoaded) {
        return state.dreamDetail.dreamComments!.length > 0
            ? Expanded(
                child: SingleChildScrollView(
                  reverse: false,
                  physics: const ScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDreamDetail(dreamDetail: state.dreamDetail),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 61, vertical: 18),
                        child: Image.asset(AssetsManager.line),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          reverse: true,
                          padding: EdgeInsets.only(
                              bottom: 110.h, top: 0, left: 24, right: 24),
                          itemCount: state.dreamDetail.dreamComments!.length,
                          separatorBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 61, vertical: 18),
                                child: Image.asset(AssetsManager.line),
                              ),
                          itemBuilder: (context, index) {
                            print(
                                'roles is ${state.dreamDetail.dreamComments![index].user!.roles}');
                            return state.dreamDetail.dreamComments![index].user!
                                    .roles!.isNotEmpty
                                ? _buildInterpreterCard(
                                    dreamComment:
                                        state.dreamDetail.dreamComments![index])
                                : _buildClientCard(
                                    dreamComment:
                                        state.dreamDetail.dreamComments![index],
                                    country: state.dreamDetail.country!);
                          }),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2 - 183.h),
                child: Center(
                  child: Text(
                    'لا يوجد أي تعليق من قبل المفسر حتي الان',
                    textAlign: TextAlign.center,
                    style: getBoldStyle(
                        color: ColorsManager.primaryDarkPurple, fontSize: 20),
                  ),
                ),
              );
      } else if (state is DreamError) {
        return Center(child: state.widget);
      } else {
        return Container();
      }
    });
  }

  Widget _buildInterpreterCard({required DreamComments dreamComment}) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 19),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: ColorsManager.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BuildCircleImage(
                            imgPath: AssetsManager.accountImage,
                            width: 80,
                            height: 80),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BuildUserNameText(
                                userName:
                                    "${tr(StringsManager.interpreterReplied)}:"),
                            BuildOrderDescriptionText(
                                description:
                                    dreamComment.user!.name.toString()),
                            const SizedBox(
                              height: 8,
                            ),
                            BuildTimeTextWithIcon(
                                time:
                                    '${getDifferenceDateTime(dateTime: dreamComment.updatedAt.toString())} '),
                          ],
                        ),
                      ],
                    ),
                  ]),
              const SizedBox(
                height: 8,
              ),
              BuildUserNameText(userName: dreamComment.content.toString()),
              _buildPlayAudio(media: dreamComment.media!)
            ]));
  }

  Widget _buildClientCard(
      {required DreamComments dreamComment, required Country country}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 19),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BuildCircleImage(
                      imgPath: AssetsManager.accountImage,
                      width: 80,
                      height: 80),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildUserNameText(
                          userName: dreamComment.user!.name.toString()),
                      Row(
                        children: [
                          BuildOrderDescriptionText(
                              description:
                                  "${tr(StringsManager.country)}: ${country.name!.ar.toString()}"),
                          // BuildCountryFlag(
                          //     countryCode:country.flag!.trimLeft().trim()
                          //      , height: 20, width: 40),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      BuildTimeTextWithIcon(
                          time:
                              '${getDifferenceDateTime(dateTime: dreamComment.updatedAt.toString())} '),
                    ],
                  ),
                ],
              ),
              // Expanded(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           BuildFavouriteIcon(
              //             onTap: () {},
              //             isFilledIcon: false,
              //           ),
              //           const SizedBox(
              //             height: 12,
              //           ),
              //           BuildOrderStatus(status: "مستعجل"),
              //         ],
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          BuildUserNameText(userName: dreamComment.content.toString()),
          _buildPlayAudio(media: dreamComment.media!),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorsManager.primaryLightPurple,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  AssetsManager.protectedIcon,
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 43.h,
                  width: 266.w,
                  child: Text(
                    tr(StringsManager.contentOfUserProtectedData),
                    style: getRegularStyle(
                        color: ColorsManager.primaryBgDark,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlayAudio({required List<Media> media}) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          media.length > 0
              ? const SizedBox(
                  height: 8,
                )
              : const SizedBox.shrink(),
          media.length > 0
              ? Text(tr(StringsManager.audioRecording),
                  style: getRegularStyle(
                      color: ColorsManager.primaryDarkPurple,
                      fontWeight: FontWeight.w700))
              : const SizedBox.shrink(),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: media.length,
            itemBuilder: (context, index) {
              return AudioCard(
                audioUrl: media[index].originalUrl.toString(),
              );
            },
          ),
        ],
      ),
    );
  }
}
