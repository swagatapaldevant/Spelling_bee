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
}