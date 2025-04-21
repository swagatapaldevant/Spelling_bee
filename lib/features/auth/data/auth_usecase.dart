
import '../../../core/network/apiHelper/resource.dart';

abstract class AuthUsecase{

  Future<Resource> languageList({required Map<String, dynamic> requestData});
  Future<Resource> logIn({required Map<String, dynamic> requestData});



}