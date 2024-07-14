class UserProfile {
  String? sId;
  String? firstName;
  String? lastName;
  String? firebaseToken;
  String? address;
  String? phone;
  String? gender;
  String? type;
  String? fullName;
  String? avatar;
  bool? isActive;
  Area? area;
  String? phoneVerifiedAt;
  int? freeTrialCount;
  String? status;
  List<dynamic>? specializations;
  String? createdAt;
  String? updatedAt;
  int? id;
  int? iV;

  UserProfile(
      {this.sId,
        this.firstName,
        this.lastName,
        this.firebaseToken,
        this.address,
        this.phone,
        this.gender,
        this.type,
        this.fullName,
        this.avatar,
        this.isActive,
        this.area,
        this.phoneVerifiedAt,
        this.freeTrialCount,
        this.status,
        this.specializations,
        this.createdAt,
        this.updatedAt,
        this.id,
        this.iV});

  UserProfile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    firebaseToken = json['firebaseToken'];
    address = json['address'];
    phone = json['phone'];
    gender = json['gender'];
    type = json['type'];
    fullName = json['full_name'];
    avatar = json['avatar'];
    isActive = json['is_active'];
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
    phoneVerifiedAt = json['phone_verified_at'];
    freeTrialCount = json['freeTrialCount'];
    status = json['status'];
    specializations =json['specializations'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['firebaseToken'] = this.firebaseToken;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['full_name'] = this.fullName;
    data['avatar'] = this.avatar;
    data['is_active'] = this.isActive;
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['freeTrialCount'] = this.freeTrialCount;
    data['status'] = this.status;
    specializations = this.specializations;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['__v'] = this.iV;
    return data;
  }
}

class Area {
  String? sId;
  Name? name;
  bool? isActive;
  City? city;
  int? id;
  int? iV;

  Area({this.sId, this.name, this.isActive, this.city, this.id, this.iV});

  Area.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    isActive = json['is_active'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['is_active'] = this.isActive;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['id'] = this.id;
    data['__v'] = this.iV;
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

class City {
  String? sId;
  Name? name;
  bool? isActive;
  int? id;
  int? iV;

  City({this.sId, this.name, this.isActive, this.id, this.iV});

  City.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    isActive = json['is_active'];
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['is_active'] = this.isActive;
    data['id'] = this.id;
    data['__v'] = this.iV;
    return data;
  }
}
