class Failure {
  int code;
  String message;

  Failure(this.code, this.message);
}

class ErrorModel {
  bool? status;
  String? message;

  ErrorModel({this.status, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = message;

    return data;
  }
}
