import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DreamController extends GetxController {
  final isCompleteDreamData = false.obs;
  final isComleteInterperterData = false.obs;
  final isCompletePlanData = false.obs;
  final isCompleteDreamOwnerData = false.obs;

  final formKeyInfoDreamData = GlobalKey<FormState>();
  final formKeyInterperterData = GlobalKey<FormState>();
  final formKeyPlanData = GlobalKey<FormState>();
  final formKeyDreamOwnerData = GlobalKey<FormState>();

  final lang = ''.obs;
  final title = ''.obs;
  final description = ''.obs;
  final userId = 0.obs;

  final interpreterId = 0.obs;
  final hasSeletedInterpreter = false.obs;

  final planId = 0.obs;
  final hasSeletedPlan = false.obs;

  final countryId = 0.obs;
  final hasSeletedCountry = false.obs;
  final TextEditingController rCountryIdController = TextEditingController();

  final startTime = ''.obs;
  final hasSelectedStartTime = false.obs;

  final maritalStatus = ''.obs;
  final hasSelectedMaritalStatus = false.obs;

  final age = ''.obs;
  final hasSelectedAge = false.obs;

  final gender = ''.obs;
  final hasSelectedGender = false.obs;

  final employed = 0.obs;
  final hasSelectedEmployed = false.obs;

  final haveChildrens = 0.obs;
  final hasSelectedHaveChildrens = false.obs;

  final dreamTime = ''.obs;
  final hasSelectedDreamTime = false.obs;

  final mentalIllness = 0.obs;
  final hasSelectedMentalIllness = false.obs;

  final guidancePrayer = 0.obs;
  final hasSelectedGuidancePrayer = false.obs;

  final notification = 0.obs;
  final hasSelectedNotification = false.obs;

  final voiceRecord = ''.obs;

  void resetAllData() {
    isCompleteDreamData.value = false;
    isComleteInterperterData.value = false;
    isCompletePlanData.value = false;
    isCompleteDreamOwnerData.value = false;
    hasSelectedAge.value = false;
    hasSelectedDreamTime.value = false;
    hasSelectedEmployed.value = false;
    hasSelectedGender.value = false;
    hasSelectedGuidancePrayer.value = false;
    hasSelectedHaveChildrens.value = false;
    hasSelectedMaritalStatus.value = false;
    hasSelectedMentalIllness.value = false;
    hasSelectedNotification.value = false;
    hasSelectedStartTime.value = false;
    hasSelectedAge.value = false;
    hasSeletedCountry.value = false;
    hasSeletedInterpreter.value = false;
    hasSeletedPlan.value = false;

    rCountryIdController.text = "";
    lang.value = '';
    title.value = '';
    description.value = '';
    userId.value = 0;
    interpreterId.value = 0;
    planId.value = 0;
    countryId.value = 0;
    startTime.value = '';
    maritalStatus.value = '';
    age.value = '';
    gender.value = '';
    employed.value = 0;
    haveChildrens.value = 0;
    dreamTime.value = '';
    mentalIllness.value = 0;
    guidancePrayer.value = 0;
    notification.value = 0;
    voiceRecord.value = '';
  }

  bool validationOnDreamData() {
    if (formKeyInfoDreamData.currentState!.validate()) {
      return isCompleteDreamData.value = true;
    } else {
      return isCompleteDreamData.value = false;
    }
  }

  bool validateionOnInterperterData() {
    if (hasSeletedInterpreter.value) {
      return isComleteInterperterData.value = true;
    } else {
      return isComleteInterperterData.value = false;
    }
  }

  bool validationOnPlanData() {
    if (hasSeletedPlan.value) {
      return isCompletePlanData.value = true;
    } else {
      return isCompletePlanData.value = false;
    }
  }

  bool validateionOnDreamOwnerData() {
    if (hasSelectedMaritalStatus.value &&
        hasSelectedAge.value &&
        hasSelectedGender.value &&
        hasSelectedEmployed.value &&
        hasSelectedHaveChildrens.value &&
        hasSelectedDreamTime.value &&
        hasSelectedMentalIllness.value &&
        hasSelectedGuidancePrayer.value) {
      return isCompleteDreamOwnerData.value = true;
    } else {
      return isCompleteDreamOwnerData.value = false;
    }
  }
}
