class FavouriteModel {
  int? id;
  int? userId;
  int? dreamId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Dream? dream;
  User? user;

  FavouriteModel(
      {this.id,
      this.userId,
      this.dreamId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.dream,
      this.user});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    dreamId = json['dream_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    dream = json['dream'] != null ? new Dream.fromJson(json['dream']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['dream_id'] = this.dreamId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.dream != null) {
      data['dream'] = this.dream!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Dream {
  int? id;
  String? title;
  String? description;
  String? status;
  int? replied;
  int? userId;
  int? interpreterId;
  int? planId;
  int? countryId;
  String? startTime;
  String? endTime;
  String? maritalStatus;
  int? age;
  String? gender;
  int? employed;
  int? haveChildrens;
  String? dreamTime;
  int? mentalIllness;
  int? guidancePrayer;
  int? notification;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Plan? plan;
  Country? country;

  Dream(
      {this.id,
      this.title,
      this.description,
      this.status,
      this.replied,
      this.userId,
      this.interpreterId,
      this.planId,
      this.countryId,
      this.startTime,
      this.endTime,
      this.maritalStatus,
      this.age,
      this.gender,
      this.employed,
      this.haveChildrens,
      this.dreamTime,
      this.mentalIllness,
      this.guidancePrayer,
      this.notification,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.plan,
      this.country});

  Dream.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    replied = json['replied'];
    userId = json['user_id'];
    interpreterId = json['interpreter_id'];
    planId = json['plan_id'];
    countryId = json['country_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    maritalStatus = json['marital_status'];
    age = json['age'];
    gender = json['gender'];
    employed = json['employed'];
    haveChildrens = json['have_childrens'];
    dreamTime = json['dream_time'];
    mentalIllness = json['mental_illness'];
    guidancePrayer = json['guidance_prayer'];
    notification = json['notification'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['replied'] = this.replied;
    data['user_id'] = this.userId;
    data['interpreter_id'] = this.interpreterId;
    data['plan_id'] = this.planId;
    data['country_id'] = this.countryId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['marital_status'] = this.maritalStatus;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['employed'] = this.employed;
    data['have_childrens'] = this.haveChildrens;
    data['dream_time'] = this.dreamTime;
    data['mental_illness'] = this.mentalIllness;
    data['guidance_prayer'] = this.guidancePrayer;
    data['notification'] = this.notification;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }
}

class Plan {
  int? id;
  Name? name;
  String? price;

  Plan({this.id, this.name, this.price});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['price'] = this.price;
    return data;
  }
}

class Name {
  String? ar;
  String? en;

  Name({this.ar, this.en});

  Name.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar'] = this.ar;
    data['en'] = this.en;
    return data;
  }
}

class Country {
  int? id;
  Name? name;
  String? flag;

  Country({this.id, this.name, this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['flag'] = this.flag;
    return data;
  }
}

class User {
  int? id;
  String? name;
  Null? avatar;
  Null? phone;
  Null? bio;
  int? blocked;
  String? email;
  String? emailVerifiedAt;
  Null? lastActivity;
  String? createdAt;
  String? updatedAt;
  int? countryId;

  User(
      {this.id,
      this.name,
      this.avatar,
      this.phone,
      this.bio,
      this.blocked,
      this.email,
      this.emailVerifiedAt,
      this.lastActivity,
      this.createdAt,
      this.updatedAt,
      this.countryId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    phone = json['phone'];
    bio = json['bio'];
    blocked = json['blocked'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    lastActivity = json['last_activity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['bio'] = this.bio;
    data['blocked'] = this.blocked;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['last_activity'] = this.lastActivity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['country_id'] = this.countryId;
    return data;
  }
}
