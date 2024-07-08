import 'user_model.dart';

class AuthResponse {
  bool? success;
  String? errNum;
  String? message;
  User? data;

  AuthResponse({this.success, this.errNum, this.message, this.data});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    success = json['status'];
    errNum = json['errNum'];
    message = json['msg'];
    data = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.errNum;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
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
  String? apiToken;
  String? imageUrl;
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
      this.apiToken,
      this.imageUrl,
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
    apiToken = json['api_token'];
    imageUrl = json['image_url'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
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
    data['api_token'] = this.apiToken;
    data['image_url'] = this.imageUrl;
    if (this.roles != null) {
      data['roles'] = [];
      //  this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  Pivot? pivot;

  Roles({this.id, this.name, this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['role_id'] = this.roleId;
    return data;
  }
}
