class GameLevelModel {
  String? icon;
  String? sId;
  String? gameId;
  int? levelNumber;
  String? difficulty;
  String? description;
  String? point;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? collectedPoints;

  GameLevelModel(
      {this.icon,
        this.sId,
        this.gameId,
        this.levelNumber,
        this.difficulty,
        this.description,
        this.point,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.collectedPoints});

  GameLevelModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    sId = json['_id'];
    gameId = json['game_id'];
    levelNumber = json['level_number'];
    difficulty = json['difficulty'];
    description = json['description'];
    point = json['point'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    collectedPoints = json['collected_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['_id'] = this.sId;
    data['game_id'] = this.gameId;
    data['level_number'] = this.levelNumber;
    data['difficulty'] = this.difficulty;
    data['description'] = this.description;
    data['point'] = this.point;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['collected_points'] = this.collectedPoints;
    return data;
  }
}