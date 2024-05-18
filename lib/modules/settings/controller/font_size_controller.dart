import 'package:get/get.dart';

class FontSizeController extends GetxController {
  final fontSize22 = 22.0.obs;
  final fontSize20 = 20.0.obs;
  final fontSize18 = 18.0.obs;
  final fontSize16 = 16.0.obs;
  final fontSize15 = 15.0.obs;
  final fontSize14 = 14.0.obs;
  final fontSize13 = 13.0.obs;
  final fontSize12 = 12.0.obs;
  final fontSize10 = 10.0.obs;

  updateFontSize({
    required double fontSize22,
    required double fontSize20,
    required double fontSize18,    
    required double fontSize16,
    required double fontSize15,
    required double fontSize14,
    required double fontSize13,
    required double fontSize12,
    required double fontSize10,
  }) {
    this.fontSize22.value = fontSize22;
    this.fontSize20.value = fontSize20;
    this.fontSize18.value = fontSize18;
    this.fontSize16.value = fontSize16;
    this.fontSize15.value = fontSize15;
    this.fontSize14.value = fontSize14;
    this.fontSize12.value = fontSize12;
    this.fontSize13.value = fontSize13;
    this.fontSize10.value = fontSize10;
  }
}
