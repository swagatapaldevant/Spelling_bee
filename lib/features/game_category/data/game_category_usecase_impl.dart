import 'package:spelling_bee/core/network/apiHelper/api_endpoint.dart';
import '../../../core/network/apiClientRepository/api_client.dart';
import '../../../core/network/apiHelper/locator.dart';
import '../../../core/network/apiHelper/resource.dart';
import '../../../core/network/apiHelper/status.dart';
import '../../../core/services/localStorage/shared_pref.dart';
import 'game_category_usecase.dart';

class GameCategoryUsecaseImplementation extends GameCategoryUsecase {

  final ApiClient _apiClient = getIt<ApiClient>();
  final SharedPref _pref = getIt<SharedPref>();


  @override
  Future<Resource> gameCategoryList(
      {required Map<String, dynamic> requestData, required String id}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
    };
    Resource resource = await _apiClient.getRequest(
        url: "${ApiEndPoint.gameCategory}$id", header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> gameListByCategory(
      {required Map<String, dynamic> requestData, required String id}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
    };
    print("Bearer$token");
    Resource resource = await _apiClient.getRequest(
        url: "${ApiEndPoint.gameListByCategory}$id", header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> gameLevelByEachGame(
      {required Map<String, dynamic> requestData, required String id, required String childId}) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
    };
    print("Bearer$token");
    Resource resource = await _apiClient.getRequest(
        url: "${ApiEndPoint.gameLevelByGame}$id/user/$childId", header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> gameQuestionAnswer(
      {required Map<String, dynamic> requestData, required String gameId, required String levelId }) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
    };
    print("Bearer$token");
    Resource resource = await _apiClient.getRequest(
        url: "${ApiEndPoint.gameQuestionAnswer}?game_id=$gameId&level_id=$levelId", header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

  @override
  Future<Resource> gameSubmit(
      {required Map<String, dynamic> requestData, }) async {
    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token"
    };
    print("Bearer$token");
    Resource resource = await _apiClient.postRequest(
        url: ApiEndPoint.gameSubmit, header: header, requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      return resource;
    } else {
      return resource;
    }
  }

}