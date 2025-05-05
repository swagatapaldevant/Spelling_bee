class GameLevelModel {
  String? sId;
  GameId? gameId;
  int? levelNumber;
  String? difficulty;
  String? description;
  String? createdAt;

  GameLevelModel(
      {this.sId,
        this.gameId,
        this.levelNumber,
        this.difficulty,
        this.description,
        this.createdAt});

  GameLevelModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameId =
    json['game_id'] != null ? new GameId.fromJson(json['game_id']) : null;
    levelNumber = json['level_number'];
    difficulty = json['difficulty'];
    description = json['description'];
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
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class GameId {
  String? sId;
  String? gameName;
  String? gameCategoryId;
  String? description;
  String? createdAt;

  GameId(
      {this.sId,
        this.gameName,
        this.gameCategoryId,
        this.description,
        this.createdAt});

  GameId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameName = json['game_name'];
    gameCategoryId = json['game_category_id'];
    description = json['description'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['game_name'] = this.gameName;
    data['game_category_id'] = this.gameCategoryId;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    return data;
  }
}