class CountriesData {
  bool? status;
  String? errNum;
  String? msg;
  List<Countries>? countries;

  CountriesData({this.status, this.errNum, this.msg, this.countries});

  CountriesData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  int? id;
  Name? name;
  String? flag;
  String? dialCode;

  Countries({this.id, this.name, this.flag, this.dialCode});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    flag = json['flag'];
    dialCode = json['dial_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['flag'] = this.flag;
    data['dial_code'] = this.dialCode;
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


// class Cities {
//   bool? success;
//   String? message;
//   List<CitiesData>? data;

//   Cities({this.success, this.message, this.data});

//   Cities.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <CitiesData>[];
//       json['data'].forEach((v) {
//         data!.add(CitiesData.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class CitiesData {
//   String? sId;
//   Name? name;
//   bool? isActive;
//   int? id;
//   int? iV;
//   List<Areas>? areas;

//   CitiesData(
//       {this.sId, this.name, this.isActive, this.id, this.iV, this.areas});

//   CitiesData.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'] != null ? new Name.fromJson(json['name']) : null;
//     isActive = json['is_active'];
//     id = json['id'];
//     iV = json['__v'];
//     if (json['areas'] != null) {
//       areas = <Areas>[];
//       json['areas'].forEach((v) {
//         areas!.add(new Areas.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     if (this.name != null) {
//       data['name'] = this.name!.toJson();
//     }
//     data['is_active'] = this.isActive;
//     data['id'] = this.id;
//     data['__v'] = this.iV;
//     if (this.areas != null) {
//       data['areas'] = this.areas!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Name {
//   String? ar;
//   String? en;

//   Name({this.ar, this.en});

//   Name.fromJson(Map<String, dynamic> json) {
//     ar = json['ar'];
//     en = json['en'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ar'] = this.ar;
//     data['en'] = this.en;
//     return data;
//   }
// }

// class Areas {
//   String? sId;
//   Name? name;
//   bool? isActive;
//   int? city;
//   int? id;
//   int? iV;

//   Areas({this.sId, this.name, this.isActive, this.city, this.id, this.iV});

//   Areas.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'] != null ? new Name.fromJson(json['name']) : null;
//     isActive = json['is_active'];
//     city = json['city'];
//     id = json['id'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     if (this.name != null) {
//       data['name'] = this.name!.toJson();
//     }
//     data['is_active'] = this.isActive;
//     data['city'] = this.city;
//     data['id'] = this.id;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
