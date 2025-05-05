
import 'package:get_it/get_it.dart';

import '../../../features/auth/data/auth_usecase.dart';
import '../../../features/auth/data/auth_usecase_impl.dart';
import '../../../features/exploreAndPlay/data/explore_play_usecase.dart';
import '../../../features/exploreAndPlay/data/explore_play_usecase_impl.dart';
import '../../../features/game_category/data/game_category_usecase.dart';
import '../../../features/game_category/data/game_category_usecase_impl.dart';
import '../../services/localStorage/shared_pref.dart';
import '../../services/localStorage/shared_pref_impl.dart';
import '../apiClientRepository/api_client.dart';
import '../apiClientRepository/api_client_impl.dart';
import '../networkRepository/network_client.dart';
import '../networkRepository/network_client_impl.dart';

final getIt = GetIt.instance;

void initializeDependency(){

  getIt.registerFactory<NetworkClient>(()=> NetworkClientImpl());
  getIt.registerFactory<SharedPref>(()=>SharedPrefImpl());
  getIt.registerFactory<ApiClient>(()=> ApiClientImpl());
  getIt.registerFactory<AuthUsecase>(()=> AuthUsecaseImplementation());
  getIt.registerFactory<ExplorePlayUsecase>(()=> ExplorePlayUsecaseImplementation());
  getIt.registerFactory<GameCategoryUsecase>(()=> GameCategoryUsecaseImplementation());






}