class AlphabetListModel {
  String? sId;
  String? learningMasterId;
  String? learningDetailsName;
  int? squence;
  String? createdAt;

  AlphabetListModel(
      {this.sId,
        this.learningMasterId,
        this.learningDetailsName,
        this.squence,
        this.createdAt});

  AlphabetListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    learningMasterId = json['learning_master_id'];
    learningDetailsName = json['learning_details_name'];
    squence = json['squence'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['learning_master_id'] = this.learningMasterId;
    data['learning_details_name'] = this.learningDetailsName;
    data['squence'] = this.squence;
    data['createdAt'] = this.createdAt;
    return data;
  }
}