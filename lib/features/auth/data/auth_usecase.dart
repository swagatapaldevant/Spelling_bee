
import '../../../core/network/apiHelper/resource.dart';

abstract class AuthUsecase{

  Future<Resource> languageList({required Map<String, dynamic> requestData});
  Future<Resource> logIn({required Map<String, dynamic> requestData});
  Future<Resource> register({required Map<String, dynamic> requestData});
  Future<Resource> updateConcern({required Map<String, dynamic> requestData});
  Future<Resource> motherLanguageList({required Map<String, dynamic> requestData});
  Future<Resource> countryList({required Map<String, dynamic> requestData});
  Future<Resource> stateList({required Map<String, dynamic> requestData, required String id});


  Future<Resource> profileData({required Map<String, dynamic> requestData});
  Future<Resource> updateProfile({required Map<String, dynamic> requestData, required String id});



}