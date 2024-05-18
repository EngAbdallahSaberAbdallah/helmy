class Interpreter {
  bool? status;
  String? errNum;
  String? msg;
  List<Interpreters>? interpreters;

  Interpreter({this.status, this.errNum, this.msg, this.interpreters});

  Interpreter.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['interpreters'] != null) {
      interpreters = <Interpreters>[];
      json['interpreters'].forEach((v) {
        interpreters!.add(new Interpreters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.interpreters != null) {
      data['interpreters'] = this.interpreters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Interpreters {
  int? id;
  String? name;
  Null? avatar;
  Null? phone;
  Null? bio;
  int? blocked;
  String? email;
  Null? emailVerifiedAt;
  Null? lastActivity;
  String? createdAt;
  String? updatedAt;
  int? countryId;
  Null? ratingsAvgRating;
  Country? country;

  Interpreters(
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
      this.ratingsAvgRating,
      this.country});

  Interpreters.fromJson(Map<String, dynamic> json) {
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
    ratingsAvgRating = json['ratings_avg_rating'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
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
    data['ratings_avg_rating'] = this.ratingsAvgRating;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
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

class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}
