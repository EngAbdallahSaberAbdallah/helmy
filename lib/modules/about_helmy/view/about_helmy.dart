import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import '../../interpreter/start/widgets/build_app_bar.dart';
import '../../start/views/drawer_view.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/values_manager.dart';

class AboutHelmy extends StatelessWidget {
  AboutHelmy({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: const DrawerView(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildAppBar(
                title: tr(StringsManager.aboutApp),
                imgAccountPath: AssetsManager.accountImage,
                iconPath: AssetsManager.menu,
                onPressedIcon: () => _scaffoldKey.currentState!.openDrawer(),
              ),
              SizedBox(
                height: 24.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 190.h,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildHeader(
                          title: "ما هو تطبيق “حلمي” ؟", context: context),
                      _spaceBetweenTexts(),
                      _buildTitle(
                          title:
                              'نحن تطبيق متخصص فى تفسير الأحلام عن طريق مجموعة من المفسرين المعتمدين. ',
                          context: context),

                      _spaceBetweenParagraphs(),

                      _buildHeader(
                          title: "كيف أعرض الحلم الخاص بي للتفسير؟  ",
                          context: context),
                      _spaceBetweenTexts(),
                      _buildTextWithDot(
                          text: 'إضغط على “إضافة حلم”', context: context),
                      _buildTextWithDot(
                          text: "قم بملئ البيانات المطلوبة", context: context),
                      _buildTextWithDot(
                          text: "أختر المفسر الذى تريد", context: context),
                      _buildTextWithDot(
                          text: "أتمم عملية الدفع", context: context),
                      _buildTitle(
                          title:
                              "بعدها ستتلقى اشعار بمجرد ان يتم تفسير الحلم الخاص بك.",
                          context: context),

                      _spaceBetweenParagraphs(),

                      // _buildHeader(title: "ما هي خطط الدفع المتوفرة؟", context: context),
                      // _spaceBetweenTexts(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextWithDot(
      {required String text, required BuildContext context}) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: ColorsManager.primaryDarkPurple,
          size: 4.sp,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w400,
              color: ColorsManager.primaryDarkPurple),
        ),
      ],
    );
  }

  Widget _spaceBetweenParagraphs() {
    return SizedBox(
      height: 8.h,
    );
  }

  Widget _spaceBetweenTexts() {
    return SizedBox(
      height: 4.h,
    );
  }

  Widget _buildHeader({required String title, required BuildContext context}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
          fontSize: 20.sp,
          color: ColorsManager.primaryDarkPurple,
          fontWeight: FontWeight.w700),
    );
  }

  Widget _buildTitle({required String title, required BuildContext context}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.w400, color: ColorsManager.primaryDarkPurple),
    );
  }

  Widget _buildBody(
      {required List<String> messages, required BuildContext context}) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 16.w),
          child: Text(
            messages[index],
            style:TextStyle(fontSize:20, color: Colors.black).copyWith(
                fontSize: AppSize.s16, color: ColorsManager.primaryDarkPurple),
          ),
        );
      },
    );
  }
}
