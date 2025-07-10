class MotherLanguageModel {
  String? name;
  String? nativeName;

  MotherLanguageModel({this.name, this.nativeName});

  MotherLanguageModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nativeName = json['nativeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['nativeName'] = this.nativeName;
    return data;
  }
}