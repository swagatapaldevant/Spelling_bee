import 'package:spelling_bee/core/network/apiHelper/api_endpoint.dart';
import 'package:spelling_bee/features/achievements/data/achievement.usecase.dart';
import '../../../core/network/apiClientRepository/api_client.dart';
import '../../../core/network/apiHelper/locator.dart';
import '../../../core/network/apiHelper/resource.dart';
import '../../../core/network/apiHelper/status.dart';
import '../../../core/services/localStorage/shared_pref.dart';

class AchievementUsecaseImplementation extends AchievementUsecase {

  final ApiClient _apiClient = getIt<ApiClient>();
  final SharedPref _pref = getIt<SharedPref>();


  @override
  Future<Resource> achievementData(
      {required Map<String, dynamic> requestData, required String id}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
    };
    Resource resource = await _apiClient.getRequest(
        url: "${ApiEndPoint.achievement}/$id", header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }


}