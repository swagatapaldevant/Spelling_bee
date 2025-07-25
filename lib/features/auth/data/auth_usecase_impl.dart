import 'package:spelling_bee/core/network/apiHelper/api_endpoint.dart';
import 'package:spelling_bee/features/auth/data/auth_usecase.dart';

import '../../../core/network/apiClientRepository/api_client.dart';
import '../../../core/network/apiHelper/locator.dart';
import '../../../core/network/apiHelper/resource.dart';
import '../../../core/network/apiHelper/status.dart';
import '../../../core/services/localStorage/shared_pref.dart';

class AuthUsecaseImplementation extends AuthUsecase {

  final ApiClient _apiClient = getIt<ApiClient>();
  final SharedPref _pref = getIt<SharedPref>();

  @override
  Future<Resource> languageList(
      {required Map<String, dynamic> requestData}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
    };
    Resource resource = await _apiClient.getRequest(
        url: ApiEndPoint.languageList, header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> logIn(
      {required Map<String, dynamic> requestData}) async {
    Map<String, String> header = {};
    Resource resource = await _apiClient.postRequest(
        url: ApiEndPoint.logIn, header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> register(
      {required Map<String, dynamic> requestData}) async {
    Map<String, String> header = {};
    Resource resource = await _apiClient.postRequest(
        url: ApiEndPoint.register, header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }


  @override
  Future<Resource> updateConcern(
      {required Map<String, dynamic> requestData}) async {
    Map<String, String> header = {};
    Resource resource = await _apiClient.postRequest(
        url: ApiEndPoint.concernSubmit, header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> motherLanguageList(
      {required Map<String, dynamic> requestData}) async {
    Map<String, String> header = {};
    Resource resource = await _apiClient.getRequest(
        url: ApiEndPoint.motherLanguageList, header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }


  @override
  Future<Resource> countryList(
      {required Map<String, dynamic> requestData}) async {
    Map<String, String> header = {};
    Resource resource = await _apiClient.getRequest(
        url: ApiEndPoint.countryList, header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> stateList(
      {required Map<String, dynamic> requestData, required String id}) async {
    Map<String, String> header = {};
    Resource resource = await _apiClient.getRequest(
        url: "${ApiEndPoint.cityList}/$id", header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> profileData(
      {required Map<String, dynamic> requestData}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
    };
    Resource resource = await _apiClient.getRequest(
        url: ApiEndPoint.profileData, header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> updateProfile(
      {required Map<String, dynamic> requestData, required String id}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
    };
    Resource resource = await _apiClient.postRequest(
        url: "${ApiEndPoint.updateProfile}/$id", header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }



}