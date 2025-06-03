
import 'package:spelling_bee/core/network/apiHelper/resource.dart';

abstract class AchievementUsecase{

  Future<Resource> achievementData({required Map<String, dynamic> requestData, required String id});



}