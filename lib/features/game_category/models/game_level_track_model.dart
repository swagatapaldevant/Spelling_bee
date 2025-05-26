class GameLevelTrackModel {
  String? sId;
  String? levelId;
  String? gameId;
  String? userId;
  String? collectedPoints;
  String? correctedAnswer;
  String? createdAt;
  String? timeTaken;

  GameLevelTrackModel(
      {this.sId,
        this.levelId,
        this.gameId,
        this.userId,
        this.collectedPoints,
        this.correctedAnswer,
        this.createdAt,
        this.timeTaken});

  GameLevelTrackModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    levelId = json['level_id'];
    gameId = json['game_id'];
    userId = json['user_id'];
    collectedPoints = json['collected_points'];
    correctedAnswer = json['corrected_answer'];
    createdAt = json['createdAt'];
    timeTaken = json['time_taken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['level_id'] = this.levelId;
    data['game_id'] = this.gameId;
    data['user_id'] = this.userId;
    data['collected_points'] = this.collectedPoints;
    data['corrected_answer'] = this.correctedAnswer;
    data['createdAt'] = this.createdAt;
    data['time_taken'] = this.timeTaken;
    return data;
  }
}