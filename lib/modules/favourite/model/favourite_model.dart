class FavouriteModel {
  int? id;
  int? userId;
  int? dreamId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
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
  Null? dreamNo;
  String? paymentRefNo;
  String? paymentStatus;
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
      this.dreamNo,
      this.paymentRefNo,
      this.paymentStatus,
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
    dreamNo = json['dream_no'];
    paymentRefNo = json['payment_ref_no'];
    paymentStatus = json['payment_status'];
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
    data['dream_no'] = this.dreamNo;
    data['payment_ref_no'] = this.paymentRefNo;
    data['payment_status'] = this.paymentStatus;
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
  String? avatar;
  Null? phone;
  Null? bio;
  int? blocked;
  String? email;
  String? emailVerifiedAt;
  Null? lastActivity;
  String? createdAt;
  String? updatedAt;
  int? countryId;
  Null? fmsToken;
  String? avatarUrl;
  List<Media>? media;

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
      this.media});

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
    return data;
  }
}

class Media {
  int? id;
  String? modelType;
  int? modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  int? size;
  // List<Null>? manipulations;
  // List<Null>? customProperties;
  GeneratedConversions? generatedConversions;
  // List<Null>? responsiveImages;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? originalUrl;
  String? previewUrl;

  Media(
      {this.id,
      this.modelType,
      this.modelId,
      this.uuid,
      this.collectionName,
      this.name,
      this.fileName,
      this.mimeType,
      this.disk,
      this.conversionsDisk,
      this.size,
      // this.manipulations,
      // this.customProperties,
      this.generatedConversions,
      // this.responsiveImages,
      this.orderColumn,
      this.createdAt,
      this.updatedAt,
      this.originalUrl,
      this.previewUrl});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    // if (json['manipulations'] != null) {
    //   manipulations = <Null>[];
    //   json['manipulations'].forEach((v) {
    //     manipulations!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['custom_properties'] != null) {
    //   customProperties = <Null>[];
    //   json['custom_properties'].forEach((v) {
    //     customProperties!.add(new Null.fromJson(v));
    //   });
    // }
    generatedConversions = json['generated_conversions'] != null
        ? new GeneratedConversions.fromJson(json['generated_conversions'])
        : null;
    // if (json['responsive_images'] != null) {
    //   responsiveImages = <Null>[];
    //   json['responsive_images'].forEach((v) {
    //     responsiveImages!.add(new Null.fromJson(v));
    //   });
    // }
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    originalUrl = json['original_url'];
    previewUrl = json['preview_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['uuid'] = this.uuid;
    data['collection_name'] = this.collectionName;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['mime_type'] = this.mimeType;
    data['disk'] = this.disk;
    data['conversions_disk'] = this.conversionsDisk;
    data['size'] = this.size;
    // if (this.manipulations != null) {
    //   data['manipulations'] =
    //       this.manipulations!.map((v) => v.toJson()).toList();
    // }
    // if (this.customProperties != null) {
    //   data['custom_properties'] =
    //       this.customProperties!.map((v) => v.toJson()).toList();
    // }
    if (this.generatedConversions != null) {
      data['generated_conversions'] = this.generatedConversions!.toJson();
    }
    // if (this.responsiveImages != null) {
    //   data['responsive_images'] =
    //       this.responsiveImages!.map((v) => v.toJson()).toList();
    // }
    data['order_column'] = this.orderColumn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['original_url'] = this.originalUrl;
    data['preview_url'] = this.previewUrl;
    return data;
  }
}

class GeneratedConversions {
  bool? tiny;
  bool? thumb;
  bool? original;

  GeneratedConversions({this.tiny, this.thumb, this.original});

  GeneratedConversions.fromJson(Map<String, dynamic> json) {
    tiny = json['tiny'];
    thumb = json['thumb'];
    original = json['original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tiny'] = this.tiny;
    data['thumb'] = this.thumb;
    data['original'] = this.original;
    return data;
  }
}
