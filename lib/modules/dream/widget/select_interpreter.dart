import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:helmy_project/modules/dream/controller/dream_controller.dart';
import 'package:helmy_project/modules/dream/cubits/interpreter_cubit/cubit/interpreter_cubit.dart';
import 'package:helmy_project/modules/dream/model/interpreter.dart';
import 'package:helmy_project/modules/home/widgets/build_country_flag.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/size_utils.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';

class SelectInterpreter extends StatefulWidget {
  SelectInterpreter({super.key});

  @override
  State<SelectInterpreter> createState() => _SelectInterpreterState();
}

class _SelectInterpreterState extends State<SelectInterpreter> {
  String? selectedInterperter = '';

  final DreamController dreamController = Get.find<DreamController>();

  int currentPage = 1;

  late List<Interpreters> interpreters = [];

  final scrollController = ScrollController();

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<InterpreterCubit>(context).getAllInterpreters();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupScrollController();
    BlocProvider.of<InterpreterCubit>(context).page = 1;
    BlocProvider.of<InterpreterCubit>(context).getAllInterpreters();
  }

  // List<User> interpreters = [
  //   User(id:1, name: 'Abdallah', avatar: 'https://helmyeg.com/images/default/avatar.png',
  //   )
  // ];

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
                              child:SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _buildListOfOrders()));
  }

  Widget _buildListOfOrders() {
    return BlocBuilder<InterpreterCubit, InterpreterState>(
        builder: (context, state) {
      if (state is InterpreterLoading && state.isFirstFetch) {
        return Transform.translate(
          offset: const Offset(0, -200),
          child: Center(child: CircularProgressIndicator()),
        );
        // _loadingShimmer();
      }

      bool isLoading = false;

      if (state is InterpreterLoading) {
        interpreters = state.oldInterpreters;
        isLoading = true;
      } else if (state is InterpreterLoaded) {
        interpreters = state.interpreters;
      }

      // } else if (state is MyDreamsLoaded) {
      return interpreters.length > 0
          ? Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.only(bottom: 20, top: 0),
                  itemCount: interpreters.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    
                    if (index < interpreters.length) {
                      return _buildInterperterCard(
                          context: context, interpreter: interpreters[index]);
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
              offset: const Offset(0, -50),
              child: Center(child: Text('لا يوجد مفسرين')));
      // const CustomEmptyScreen(url: AssetsManager.emptyOrderScreen)

      // } else if (state is MyDreamsError) {
      //   return Center(child: state.exceptionWidget);
      // } else {
      //   return Container();
      // }
    });
  }

  Widget _buildInterperterCard(
      {required BuildContext context, required Interpreters interpreter}) {
    return InkWell(
      onTap: () {
        dreamController.interpreterId.value = 1;
        dreamController.hasSeletedInterpreter.value = true;
        setState(() {
          selectedInterperter = interpreter.id.toString();
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 9),
        padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 14.22),
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
            Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorsManager.white, width: 1.5),
                ),
                child: selectedInterperter == '${interpreter.id}'
                    ? Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                            color: ColorsManager.primaryDarkPurple,
                            shape: BoxShape.circle),
                      )
                    : const SizedBox.shrink()),
            const SizedBox(
              width: 4,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //   Container(
                //     width: 65,height: 65,
                //   decoration: const BoxDecoration(
                //     shape: BoxShape.circle,
                //     image: DecorationImage(image: NetworkImage(""),fit: BoxFit.cover)
                //   ),
                //  ),
                _buildCircleImage(
                    imgPath: interpreter.avatar ??
                        'https://helmyeg.com/images/default/avatar.png',
                    width: 65,
                    height: 65),
                _spacerHeight(),
                //  Image.network('', width: 26.67, height:20 ,fit: BoxFit.cover,),

                BuildCountryFlag(countryCode: interpreter.country!.flag!,),

                _spacerHeight(),
                Text(
                  interpreter.ratingsAvgRating.toString(),
                  style: getRegularStyle(
                      color: ColorsManager.textShade,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            _buildInterpreterInfoAndDream(interpreter: interpreter)
          ],
        ),
      ),
    );
  }

  Widget _buildInterpreterInfoAndDream({required Interpreters interpreter}) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(top: 25.78),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${tr(StringsManager.interpreter)} ${interpreter.name.toString()} ",
                style: getRegularStyle(
                    color: ColorsManager.primaryDarkPurple,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                child: Text(
                  interpreter.bio ??
                      'خبرة اكثر من 15 سنوات فى التفسير وعندى علم بالأمراض الروحية و اهتم بتحليل الرموز المنامية و الاستنباط',
                  style: getRegularStyle(
                      color: ColorsManager.primaryDarkPurple,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          )),
    );
  }

  Widget _spacerHeight() {
    return const SizedBox(
      height: 8,
    );
  }

  Widget _buildCircleImage(
      {required String imgPath,
      required double width,
      required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imgPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
