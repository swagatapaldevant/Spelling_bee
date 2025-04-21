import 'package:spelling_bee/core/network/apiHelper/api_endpoint.dart';
import 'package:spelling_bee/features/auth/data/auth_usecase.dart';

import '../../../core/network/apiClientRepository/api_client.dart';
import '../../../core/network/apiHelper/locator.dart';
import '../../../core/network/apiHelper/resource.dart';
import '../../../core/network/apiHelper/status.dart';
import '../../../core/services/localStorage/shared_pref.dart';
import 'explore_play_usecase.dart';

class ExplorePlayUsecaseImplementation extends ExplorePlayUsecase {

  final ApiClient _apiClient = getIt<ApiClient>();
  final SharedPref _pref = getIt<SharedPref>();


  @override
  Future<Resource> learningAlphabetType(
      {required Map<String, dynamic> requestData, required String id}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
    };
    Resource resource = await _apiClient.getRequest(
        url: "${ApiEndPoint.learningLetterType}$id", header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> bengaliAlphabetList(
      {required Map<String, dynamic> requestData, required String id}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
    };
    print("Bearer$token");
    Resource resource = await _apiClient.getRequest(
        url: "${ApiEndPoint.bengaliAlphabetListApi}$id", header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

}