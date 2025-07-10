class CountryListModel {
  String? shortName;
  String? name;
  String? native;
  String? phone;
  String? continent;
  String? capital;
  String? currency;
  List<String>? languages;
  String? emoji;
  String? emojiU;

  CountryListModel(
      {this.shortName,
        this.name,
        this.native,
        this.phone,
        this.continent,
        this.capital,
        this.currency,
        this.languages,
        this.emoji,
        this.emojiU});

  CountryListModel.fromJson(Map<String, dynamic> json) {
    shortName = json['shortName'];
    name = json['name'];
    native = json['native'];
    phone = json['phone'];
    continent = json['continent'];
    capital = json['capital'];
    currency = json['currency'];
    languages = json['languages'].cast<String>();
    emoji = json['emoji'];
    emojiU = json['emojiU'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shortName'] = this.shortName;
    data['name'] = this.name;
    data['native'] = this.native;
    data['phone'] = this.phone;
    data['continent'] = this.continent;
    data['capital'] = this.capital;
    data['currency'] = this.currency;
    data['languages'] = this.languages;
    data['emoji'] = this.emoji;
    data['emojiU'] = this.emojiU;
    return data;
  }
}