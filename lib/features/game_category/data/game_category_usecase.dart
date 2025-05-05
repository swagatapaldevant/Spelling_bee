
import '../../../core/network/apiHelper/resource.dart';

abstract class GameCategoryUsecase{

  Future<Resource> gameCategoryList({required Map<String, dynamic> requestData, required String id});
  Future<Resource> gameListByCategory({required Map<String, dynamic> requestData, required String id});
  Future<Resource> gameLevelByEachGame({required Map<String, dynamic> requestData, required String id});



}