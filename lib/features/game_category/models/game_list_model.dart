class GameListModel {
  String? sId;
  String? gameName;
  GameCategoryId? gameCategoryId;
  String? description;
  String? createdAt;

  GameListModel(
      {this.sId,
        this.gameName,
        this.gameCategoryId,
        this.description,
        this.createdAt});

  GameListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameName = json['game_name'];
    gameCategoryId = json['game_category_id'] != null
        ? new GameCategoryId.fromJson(json['game_category_id'])
        : null;
    description = json['description'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['game_name'] = this.gameName;
    if (this.gameCategoryId != null) {
      data['game_category_id'] = this.gameCategoryId!.toJson();
    }
    data['description'] = this.description;
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


// final List<GameModel> dummyGameList = [
//   GameModel(
//     id: 0,
//     name: 'Match Letters',
//     imagePath: 'assets/images/level_1.png',
//   ),
//   GameModel(
//     id: 1,
//     name: 'Spelling Bee',
//     imagePath: 'assets/images/level_2.png',
//   ),
//   GameModel(
//     id: 2,
//     name: 'Word Builder',
//     imagePath: 'assets/images/level_3.png',
//   ),
//   GameModel(
//     id: 3,
//     name: 'Rhyme Time',
//     imagePath: 'assets/images/level_1.png',
//   ),
//   GameModel(
//     id: 4,
//     name: 'Letter Hunt',
//     imagePath: 'assets/images/level_2.png',
//   ), GameModel(
//     id: 5,
//     name: 'Hindi Hunt',
//     imagePath: 'assets/images/level_2.png',
//   ), GameModel(
//     id: 6,
//     name: 'Urdu Hunt',
//     imagePath: 'assets/images/level_2.png',
//   ), GameModel(
//     id: 7,
//     name: 'English Hunt',
//     imagePath: 'assets/images/level_2.png',
//   ),
// ];
