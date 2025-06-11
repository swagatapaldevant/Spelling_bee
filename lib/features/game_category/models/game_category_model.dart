class GameCategoryModel {
  String? sId;
  List<CategoryName>? categoryName;
  Language? language;
  List<Games>? games;

  GameCategoryModel({this.sId, this.categoryName, this.language, this.games});

  GameCategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['category_name'] != null) {
      categoryName = <CategoryName>[];
      json['category_name'].forEach((v) {
        categoryName!.add(new CategoryName.fromJson(v));
      });
    }
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    if (json['games'] != null) {
      games = <Games>[];
      json['games'].forEach((v) {
        games!.add(new Games.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.categoryName != null) {
      data['category_name'] =
          this.categoryName!.map((v) => v.toJson()).toList();
    }
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    if (this.games != null) {
      data['games'] = this.games!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryName {
  String? sId;
  String? gameCategoryName;
  Language? language;
  String? description;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<Games>? games;

  CategoryName(
      {this.sId,
        this.gameCategoryName,
        this.language,
        this.description,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.games});

  CategoryName.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameCategoryName = json['game_category_name'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    description = json['description'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['games'] != null) {
      games = <Games>[];
      json['games'].forEach((v) {
        games!.add(new Games.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['game_category_name'] = this.gameCategoryName;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    data['description'] = this.description;
    data['is_deleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.games != null) {
      data['games'] = this.games!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Language {
  String? sId;
  String? languageName;
  String? description;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Language(
      {this.sId,
        this.languageName,
        this.description,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Language.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    languageName = json['language_name'];
    description = json['description'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['language_name'] = this.languageName;
    data['description'] = this.description;
    data['is_deleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

// class Games {
//   String? sId;
//   String? gameName;
//   String? icon;
//   String? backgroundImage;
//   String? storyTitle;
//   String? storyDescription;
//   String? gameCategoryId;
//   String? description;
//   String? mechanismId;
//   bool? isDeleted;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//
//   Games(
//       {this.sId,
//         this.gameName,
//         this.icon,
//         this.backgroundImage,
//         this.storyTitle,
//         this.storyDescription,
//         this.gameCategoryId,
//         this.description,
//         this.mechanismId,
//         this.isDeleted,
//         this.createdAt,
//         this.updatedAt,
//         this.iV});
//
//   Games.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     gameName = json['game_name'];
//     icon = json['icon'];
//     backgroundImage = json['background_image'];
//     storyTitle = json['story_title'];
//     storyDescription = json['story_description'];
//     gameCategoryId = json['game_category_id'];
//     description = json['description'];
//     mechanismId = json['mechanism_id'];
//     isDeleted = json['is_deleted'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['game_name'] = this.gameName;
//     data['icon'] = this.icon;
//     data['background_image'] = this.backgroundImage;
//     data['story_title'] = this.storyTitle;
//     data['story_description'] = this.storyDescription;
//     data['game_category_id'] = this.gameCategoryId;
//     data['description'] = this.description;
//     data['mechanism_id'] = this.mechanismId;
//     data['is_deleted'] = this.isDeleted;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

class Games {
  String? sId;
  String? gameName;
  int? totalLevels;
  int? completedLevels;

  Games({this.sId, this.gameName, this.totalLevels, this.completedLevels});

  Games.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameName = json['game_name'];
    totalLevels = json['totalLevels'];
    completedLevels = json['completedLevels'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['game_name'] = this.gameName;
    data['totalLevels'] = this.totalLevels;
    data['completedLevels'] = this.completedLevels;
    return data;
  }
}