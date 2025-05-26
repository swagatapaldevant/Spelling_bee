class GameCategoryModel {
  String? sId;
  String? gameCategoryName;
  Language? language;
  String? description;
  String? createdAt;
  int? gameCount;

  GameCategoryModel(
      {this.sId,
        this.gameCategoryName,
        this.language,
        this.description,
        this.gameCount,
        this.createdAt});

  GameCategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameCategoryName = json['game_category_name'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    description = json['description'];
    createdAt = json['createdAt'];
    gameCount = json['gameCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['game_category_name'] = this.gameCategoryName;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['gameCount'] = this.gameCount;
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