class GameQuestion {
  final String question;
  final List<String> options;
  final String answer;

  GameQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });
}


class QuestionDetailsModel {
  String? sId;
  String? gameId;
  String? levelId;
  String? question;
  List<String>? answer;
  String? correctAnswer;
  String? image;
  String? createdAt;

  QuestionDetailsModel(
      {this.sId,
        this.gameId,
        this.levelId,
        this.question,
        this.answer,
        this.correctAnswer,
        this.image,
        this.createdAt});

  QuestionDetailsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameId = json['game_id'];
    levelId = json['level_id'];
    question = json['question'];
    answer = json['answer'].cast<String>();
    correctAnswer = json['correct_answer'];
    image = json['image'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['game_id'] = this.gameId;
    data['level_id'] = this.levelId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['correct_answer'] = this.correctAnswer;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    return data;
  }
}