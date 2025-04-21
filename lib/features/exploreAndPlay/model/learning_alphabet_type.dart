class LearningAlphabetType {
  String? sId;
  String? learningName;
  Language? language;
  String? createdAt;

  LearningAlphabetType(
      {this.sId, this.learningName, this.language, this.createdAt});

  LearningAlphabetType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    learningName = json['learning_name'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['learning_name'] = this.learningName;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Language {
  String? sId;
  String? languageName;
  String? description;
  String? createdAt;

  Language({this.sId, this.languageName, this.description, this.createdAt});

  Language.fromJson(Map<String, dynamic> json) {
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