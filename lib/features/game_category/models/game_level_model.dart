class GameLevelModel {
  String? sId;
  GameId? gameId;
  int? levelNumber;
  String? difficulty;
  String? description;
  String? point;
  String? icon;
  String? createdAt;

  GameLevelModel(
      {this.sId,
        this.gameId,
        this.levelNumber,
        this.difficulty,
        this.description,
        this.point,
        this.icon,
        this.createdAt});

  GameLevelModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameId =
    json['game_id'] != null ? new GameId.fromJson(json['game_id']) : null;
    levelNumber = json['level_number'];
    difficulty = json['difficulty'];
    description = json['description'];
    point = json['point'];
    icon = json['icon'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.gameId != null) {
      data['game_id'] = this.gameId!.toJson();
    }
    data['level_number'] = this.levelNumber;
    data['difficulty'] = this.difficulty;
    data['description'] = this.description;
    data['point'] = this.point;
    data['icon'] = this.icon;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class GameId {
  String? sId;
  String? gameName;
  String? icon;
  String? backgroundImage;
  String? storyTitle;
  String? storyDescription;
  String? gameCategoryId;
  String? description;
  String? mechanismId;
  String? createdAt;

  GameId(
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

  GameId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameName = json['game_name'];
    icon = json['icon'];
    backgroundImage = json['background_image'];
    storyTitle = json['story_title'];
    storyDescription = json['story_description'];
    gameCategoryId = json['game_category_id'];
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
    data['game_category_id'] = this.gameCategoryId;
    data['description'] = this.description;
    data['mechanism_id'] = this.mechanismId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}