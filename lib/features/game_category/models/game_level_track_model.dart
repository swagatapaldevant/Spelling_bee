class GameLevelTrackModel {
  String? sId;
  String? userId;
  String? gameId;
  String? levelId;
  String? correctedAnswer;
  int? collectedPoints;
  String? timeTaken;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? collectedPointsNum;

  GameLevelTrackModel(
      {this.sId,
        this.userId,
        this.gameId,
        this.levelId,
        this.correctedAnswer,
        this.collectedPoints,
        this.timeTaken,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.collectedPointsNum});

  GameLevelTrackModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    gameId = json['game_id'];
    levelId = json['level_id'];
    correctedAnswer = json['corrected_answer'];
    collectedPoints = json['collected_points'];
    timeTaken = json['time_taken'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    collectedPointsNum = json['collected_points_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['game_id'] = this.gameId;
    data['level_id'] = this.levelId;
    data['corrected_answer'] = this.correctedAnswer;
    data['collected_points'] = this.collectedPoints;
    data['time_taken'] = this.timeTaken;
    data['is_deleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['collected_points_num'] = this.collectedPointsNum;
    return data;
  }
}