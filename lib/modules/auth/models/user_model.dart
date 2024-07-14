class User {
  bool? success;
  String? message;
  UserData? data;

  User({this.success, this.message, this.data});

  User.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? avatar;
  String? name;
  String? email;
  String? phone;
  String? bio;
  bool? blocked;
  int? countryId;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? token;

  UserData(
      {
        this.avatar,
        this.name,
        this.email,
        this.phone,
        this.bio,
        this.blocked,
        this.countryId,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.token,
      });

  UserData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'] ?? "";
    name = json['name'];
    email = json['email'];
    phone = json['phone'] ?? "";
    bio = json['bio'] ?? "";
    countryId = json['country_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['api_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    // data['country_id'] = countryId;
    data['phone'] = phone;
    data['bio'] = bio;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['api_token'] = token;
    return data;
  }
}
