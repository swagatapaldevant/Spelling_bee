class AchievementResultModel {
  int? totalTimePlayed;
  double? totalCoinsEarned;
  String? date;
  String? day;

  AchievementResultModel(
      {this.totalTimePlayed, this.totalCoinsEarned, this.date, this.day});

  AchievementResultModel.fromJson(Map<String, dynamic> json) {
    totalTimePlayed = json['totalTimePlayed'];
    totalCoinsEarned = json['totalCoinsEarned'] != null
        ? (json['totalCoinsEarned'] as num).toDouble()
        : null;
    date = json['date'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalTimePlayed'] = this.totalTimePlayed;
    data['totalCoinsEarned'] = this.totalCoinsEarned;
    data['date'] = this.date;
    data['day'] = this.day;
    return data;
  }
}