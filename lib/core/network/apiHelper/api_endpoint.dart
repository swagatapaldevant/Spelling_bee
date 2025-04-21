
class ApiEndPoint{

  static final ApiEndPoint _instance = ApiEndPoint._internal();

  factory ApiEndPoint(){
    return _instance;
  }

  ApiEndPoint._internal();

  //static const baseurl = "http://192.168.29.243:8001/api";
  static const baseurl = "https://thecityofjoy.in/spelling_bee_backend/api";

  //auth module
  static const languageList =  "$baseurl/language/get-delete";
  static const logIn =  "$baseurl/user/login";


  static const learningLetterType =  "$baseurl/learning-master/by-language/";
  static const bengaliAlphabetListApi =  "$baseurl/learning-details/get-learning-details-by-master-id/";







}