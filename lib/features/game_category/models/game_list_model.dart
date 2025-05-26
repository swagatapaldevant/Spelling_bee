class GameListModel {
  String? sId;
  String? gameName;
  String? icon;
  String? backgroundImage;
  String? storyTitle;
  String? storyDescription;
  GameCategoryId? gameCategoryId;
  String? description;
  String? mechanismId;
  String? createdAt;

  GameListModel(
      {this.sId,
        this.gameName,
        this.icon,
        this.backgroundImage,
        this.storyTitle,
        this.storyDescription,
        this.gameCategoryId,
        this.description,
        this.mechanismId,
        this.createdAt});

  GameListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameName = json['game_name'];
    icon = json['icon'];
    backgroundImage = json['background_image'];
    storyTitle = json['story_title'];
    storyDescription = json['story_description'];
    gameCategoryId = json['game_category_id'] != null
        ? new GameCategoryId.fromJson(json['game_category_id'])
        : null;
    description = json['description'];
    mechanismId = json['mechanism_id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['game_name'] = this.gameName;
    data['icon'] = this.icon;
    data['background_image'] = this.backgroundImage;
    data['story_title'] = this.storyTitle;
    data['story_description'] = this.storyDescription;
    if (this.gameCategoryId != null) {
      data['game_category_id'] = this.gameCategoryId!.toJson();
    }
    data['description'] = this.description;
    data['mechanism_id'] = this.mechanismId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class GameCategoryId {
  String? sId;
  String? gameCategoryName;
  String? language;
  String? description;
  String? createdAt;

  GameCategoryId(
      {this.sId,
        this.gameCategoryName,
        this.language,
        this.description,
        this.createdAt});

  GameCategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameCategoryName = json['game_category_name'];
    language = json['language'];
    description = json['description'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['game_category_name'] = this.gameCategoryName;
    data['language'] = this.language;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    return data;
  }
}