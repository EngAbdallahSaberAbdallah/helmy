import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widget/layout.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';

const String privacyPolicyAr = '''
نحن ملتزمون بحماية خصوصيتك. يصف إشعار الخصوصية هذا كيف نجمع معلوماتك الشخصية ونستخدمها ونكشفها عند زيارة أو استخدام خدمتنا.
المعلومات التي نجمعها
نقوم بجمع أنواع مختلفة من المعلومات من أجل توفير وتحسين خدمتنا لك.
المعلومات الشخصية
أثناء استخدام خدمتنا، قد نطلب منك تزويدنا ببعض معلومات التعريف الشخصية التي يمكن استخدامها للاتصال بك أو التعرف عليك.
استخدام البيانات
نستخدم البيانات التي نجمعها لتوفير وتحسين الخدمة. يتضمن استخدام البيانات: تزويدك بالخدمة وتحسينها، وإعلامك بالتغييرات على خدمتنا، وتزويدك بدعم العملاء.
التغييرات على سياسة الخصوصية هذه
قد نقوم بتحديث سياسة الخصوصية الخاصة بنا من وقت لآخر. سنعلمك بأي تغييرات عن طريق نشر سياسة الخصوصية الجديدة على هذه الصفحة.
''';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: Text(
          privacyPolicyAr,
          style: getRegularStyle(
              color: ColorsManager.primaryDarkPurple,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        appBarTitle: tr(StringsManager.privacy));
  }
}
