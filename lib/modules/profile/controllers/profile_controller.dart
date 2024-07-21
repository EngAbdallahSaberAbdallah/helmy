import 'package:get/get.dart';

class ProfileController extends GetxController{
  final profileImage = ''.obs;

  void updateProfileImage({required String image}){
    profileImage.value = image;
  }
}