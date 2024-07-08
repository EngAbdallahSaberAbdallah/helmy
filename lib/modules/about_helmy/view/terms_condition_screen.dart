import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:helmy_project/modules/about_helmy/widget/layout.dart';
import 'package:helmy_project/resources/strings_manager.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: _buildTermsConditions(),
        appBarTitle: tr(StringsManager.termsAndConditions));
  }

  Widget _buildTermsConditions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'الشروط والأحكام',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'مرحباً بك في تطبيقنا. باستخدام هذا التطبيق، فإنك توافق على الالتزام بالشروط والأحكام التالية:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          '1. الاستخدام المقبول',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'يجب عليك استخدام هذا التطبيق بطريقة قانونية ومسؤولة. لا يُسمح لك باستخدام التطبيق لأي غرض غير قانوني أو غير أخلاقي.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          '2. الملكية الفكرية',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'جميع المحتويات والمواد المتاحة عبر هذا التطبيق محمية بحقوق الطبع والنشر والعلامات التجارية والقوانين الأخرى المتعلقة بالملكية الفكرية.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          '3. التعديلات على الشروط',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'نحتفظ بالحق في تعديل هذه الشروط والأحكام في أي وقت. ستكون التعديلات سارية المفعول فور نشرها على هذا التطبيق.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          '4. حدود المسؤولية',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'لن نكون مسؤولين عن أي أضرار ناتجة عن استخدامك لهذا التطبيق أو عدم قدرتك على استخدامه.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          '5. الاتصال بنا',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'إذا كان لديك أي استفسارات حول هذه الشروط والأحكام، يرجى الاتصال بنا عبر البريد الإلكتروني.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
