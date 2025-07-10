class ProfileDataModel {
  String? sId;
  String? name;
  String? email;
  String? motherTongue;
  int? yearOfBirth;
  String? city;
  String? country;
  String? userType;
  List<bool>? parentConsent;
  int? iV;
  String? language;

  ProfileDataModel(
      {this.sId,
        this.name,
        this.email,
        this.motherTongue,
        this.yearOfBirth,
        this.city,
        this.country,
        this.userType,
        this.parentConsent,
        this.iV,
        this.language});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    motherTongue = json['motherTongue'];
    yearOfBirth = json['yearOfBirth'];
    city = json['city'];
    country = json['country'];
    userType = json['userType'];
    parentConsent = json['parent_consent'].cast<bool>();
    iV = json['__v'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['motherTongue'] = this.motherTongue;
    data['yearOfBirth'] = this.yearOfBirth;
    data['city'] = this.city;
    data['country'] = this.country;
    data['userType'] = this.userType;
    data['parent_consent'] = this.parentConsent;
    data['__v'] = this.iV;
    data['language'] = this.language;
    return data;
  }
}