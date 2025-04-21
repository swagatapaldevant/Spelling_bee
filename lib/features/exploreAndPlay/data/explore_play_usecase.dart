
import '../../../core/network/apiHelper/resource.dart';

abstract class ExplorePlayUsecase{

  Future<Resource> learningAlphabetType({required Map<String, dynamic> requestData, required String id});
  Future<Resource> bengaliAlphabetList({required Map<String, dynamic> requestData, required String id});



}