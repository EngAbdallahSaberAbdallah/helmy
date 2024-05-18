class Plans {
  int? planId;
  String? planName;
  List<String>? planData;
  double? price;

  Plans({required this.planData, required this.planName, required this.price});

  Plans.fromJson(Map<String, dynamic> json) {
    planId = json['id'];
    planData = json['planData'];
    planName = json['planName'];
    price = json['price'].toDouble();
  }
}