
import 'dart:io';

class Dream {
  late final String title,
      description,  dreamTime,age,  materialStatus,
      gender;
  late final int userId,
      interpreterId,
      planId,
      countryId,
    
      employed,
      haveChildrens,    
      mentalIllness,
      guidancePrayer,
      notification; 

  late File voiceRecord;

  Dream(
      {required this.title,
      required this.description,
      required this.userId,
      required this.interpreterId,
      required this.planId,
      required this.countryId,
      required this.materialStatus,
      required this.age,
      required this.gender,
      required this.employed,
      required this.haveChildrens,
      required this.dreamTime,
      required this.mentalIllness,
      required this.guidancePrayer,
      required this.notification,
      required this.voiceRecord});

  Map<String, dynamic> toJson(){
    return {
      "lang":"ar",
      'title':title,
      'description':description,
      'user_id':1,
      'interpreter_id':interpreterId,
      'plan_id':planId,
      'country_id':1,
      'marital_status':materialStatus,
      'age':age,
      'gender':gender,
      'employed':employed,
      'have_childrens':haveChildrens,
      'dream_time':dreamTime,
      'mental_illness':mentalIllness,
      'guidance_prayer':guidancePrayer,
      'notification':0,
      'voice_record':voiceRecord
    };
  }
}
