import 'package:get/get.dart';
import 'package:helmy_project/modules/dream/controller/dream_controller.dart';
import 'package:helmy_project/modules/settings/controller/font_size_controller.dart';

class GetXControllers {

  // static final DreamController dreamController = Get.find<DreamController>();
  static final FontSizeController fontSizeController = Get.find<FontSizeController>();

  static void putControllers(){
    Get.put(DreamController());
    Get.put(FontSizeController());
  }
}