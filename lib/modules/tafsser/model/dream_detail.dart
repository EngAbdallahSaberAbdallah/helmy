import 'package:helmy_project/modules/favourite/model/favourite_model.dart';

class DreamDetail {
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
  String? voiceRecordUrl;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? dreamNo;
  String? paymentRefNo;
  String? paymentStatus;
  Plan? plan;
  Country? country;
  User? user;
  List<Media>? media;
  List<DreamComments>? dreamComments;

  DreamDetail(
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
      this.voiceRecordUrl,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.dreamNo,
      this.paymentRefNo,
      this.paymentStatus,
      this.plan,
      this.country,
      this.user,
      this.media,
      this.dreamComments});

  DreamDetail.fromJson(Map<String, dynamic> json) {
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
    voiceRecordUrl = json['voice_record_url'] ?? "";
    if (json['dream_comments'] != null) {
      dreamComments = <DreamComments>[];
      json['dream_comments'].forEach((v) {
        dreamComments!.add(DreamComments.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    dreamNo = json['dream_no'];
    paymentRefNo = json['payment_ref_no'];
    paymentStatus = json['payment_status'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
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
    data['voice_record_url'] = this.voiceRecordUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['dream_no'] = this.dreamNo;
    data['payment_ref_no'] = this.paymentRefNo;
    data['payment_status'] = this.paymentStatus;
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DreamComments {
  int? id;
  String? content;
  int? dreamId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Media>? media;
  User? user;

  DreamComments(
      {this.id,
      this.content,
      this.dreamId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.media,
      this.user});

  DreamComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    dreamId = json['dream_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['dream_id'] = this.dreamId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Plan {
  int? id;
  Name? name;
  String? price;
  int? userCanRespond;

  Plan({this.id, this.name, this.price, this.userCanRespond});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    price = json['price'];
    userCanRespond = json['user_can_respond'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['price'] = this.price;
    data['user_can_respond'] = this.userCanRespond;
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
  String? avatar;
  String? phone;
  String? bio;
  int? blocked;
  String? email;
  String? emailVerifiedAt;
  String? lastActivity;
  String? createdAt;
  String? updatedAt;
  int? countryId;
  String? fmsToken;
  String? avatarUrl;
  List<Media>? media;
  List<Roles>? roles;

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
      this.countryId,
      this.fmsToken,
      this.avatarUrl,
      this.media,
      this.roles});

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
    fmsToken = json['fmsToken'];
    avatarUrl = json['avatar_url'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['media'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
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
    data['fmsToken'] = this.fmsToken;
    data['avatar_url'] = this.avatarUrl;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? guardName;
  String? displayName;
  String? description;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Roles(
      {this.id,
      this.name,
      this.guardName,
      this.displayName,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    displayName = json['display_name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    data['display_name'] = this.displayName;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  String? modelType;
  int? modelId;
  int? roleId;

  Pivot({this.modelType, this.modelId, this.roleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    modelType = json['model_type'];
    modelId = json['model_id'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['role_id'] = this.roleId;
    return data;
  }
}
