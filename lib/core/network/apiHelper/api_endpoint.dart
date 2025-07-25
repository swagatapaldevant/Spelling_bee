class ApiEndPoint {
  static final ApiEndPoint _instance = ApiEndPoint._internal();

  factory ApiEndPoint() {
    return _instance;
  }

  ApiEndPoint._internal();

  //static const baseurl = "http://192.168.29.243:8001/api";
  static const baseurl = "https://thecityofjoy.in/spelling_bee_backend/api";
  //static const baseurl = "http://192.168.29.216:5000/api";

  //static const domain = "http://192.168.29.216:5000";

  static const domain  = "https://thecityofjoy.in/spelling_bee_backend";

  //auth module
  static const languageList = "$baseurl/language/get-delete";
  static const logIn = "$baseurl/user/login";
  static const register = "$baseurl/user/register";
  static const concernSubmit = "$baseurl/user/consent";
  static const motherLanguageList = "$baseurl/user/getLanguage";
  static const countryList = "$baseurl/user/getCountry";
  static const cityList = "$baseurl/user/getCity";

  static const profileData = "$baseurl/user/getLoginUser";
  static const updateProfile = "$baseurl/user/edit_user";



  static const learningLetterType = "$baseurl/learning-master/by-language/";
  static const bengaliAlphabetListApi =
      "$baseurl/learning-details/get-learning-details-by-master-id/";

  // game category list
  static const gameCategory = "$baseurl/game-category/by-language/";
  static const gameListByCategory = "$baseurl/game/get-by-category-id/";
  static const gameLevelByGame =
      "$baseurl/game-level/get-game-level-by-game-id/";
  static const gameQuestionAnswer =
      "$baseurl/game-details/start-game-question-answer";
  static const gameSubmit = "$baseurl/game-details/userwise-game-level-save";

  //achievement
  static const achievement = "$baseurl/user/achievements";
}
