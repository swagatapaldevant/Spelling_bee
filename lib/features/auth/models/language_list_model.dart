class LanguageListModel {
  String? sId;
  String? languageName;
  String? description;
  String? createdAt;

  LanguageListModel(
      {this.sId, this.languageName, this.description, this.createdAt});

  LanguageListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    languageName = json['language_name'];
    description = json['description'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['language_name'] = this.languageName;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    return data;
  }
}