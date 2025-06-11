class TopThreeUserModel {
  String? userId;
  String? name;
  int? totalCoins;

  TopThreeUserModel({this.userId, this.name, this.totalCoins});

  TopThreeUserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    totalCoins = json['totalCoins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['totalCoins'] = this.totalCoins;
    return data;
  }
}