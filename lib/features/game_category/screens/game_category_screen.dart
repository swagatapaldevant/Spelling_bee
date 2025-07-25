import 'package:flutter/material.dart';
import 'package:spelling_bee/core/network/apiHelper/locator.dart';
import 'package:spelling_bee/core/services/localStorage/shared_pref.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/features/game_category/data/game_category_usecase.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../core/network/apiHelper/resource.dart';
import '../../../core/network/apiHelper/status.dart';
import '../../../core/utils/helper/common_utils.dart';
import '../models/game_category_model.dart';
import '../models/game_list_model.dart';
import '../widgets/game_category_header.dart';
import '../widgets/game_item.dart';

class GameCategoryScreen extends StatefulWidget {
  const GameCategoryScreen({super.key});

  @override
  State<GameCategoryScreen> createState() => _GameCategoryScreenState();
}

class _GameCategoryScreenState extends State<GameCategoryScreen> {
  final GameCategoryUsecase _gameCategoryUsecase = getIt<GameCategoryUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<GameCategoryModel> gameCategoryList = [];
  List<GameListModel> gameListByCategory = [];
  //List<Game> gameList = [];

  @override
  void initState() {
    super.initState();
    listOfGameCategory();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      backgroundColor: AppColors.parentConcernBg,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              "assets/images/alphabet/alphabet_details_bg.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          // Gradient overlay with scrollable content
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white.withOpacity(0.4),
                    AppColors.white.withOpacity(0.7),
                    AppColors.white,
                  ],
                ),
              ),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.containerColor,
                      ),
                    )
                  : CustomScrollView(
                      slivers: [
                        // Header section
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.screenPadding,
                              vertical: 16,
                            ),
                            child: const GameCategoryHeader(),
                          ),
                        ),

                        // Grid view section
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.screenPadding,
                          ),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 0.9,
                              //mainAxisExtent: 180, // Fixed height for each item
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                int totalLevel = 0;
                                int totalPlayedLevel = 0;

                                final category = gameCategoryList[index];
                                if(category.games!.isEmpty)
                                {
                                  totalLevel = 0;
                                  totalPlayedLevel = 0;
                                }else {
                                  // Safely loop through the games of the current category
                                  for (int j = 0; j <
                                      category.games!.length; j++) {
                                    final game = category.games?[j];

                                    totalLevel += game?.totalLevels ?? 0;
                                    totalPlayedLevel +=
                                        game?.completedLevels ?? 0;
                                  }
                                }
                                //
                                // print(totalLevel);
                                // print(totalPlayedLevel);

                                return AnimatedGameItem(
                                  totalLevel: totalLevel,
                                  totalPlayedLevel: totalPlayedLevel,
                                  index: index,
                                  onTap: () {
                                    gameCategoryList[index].games!.isEmpty
                                        ? showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                        message:
                                        "No game available in this category",
                                      ),
                                    )
                                        : listOfGameByCategory(
                                        gameCategoryList[index]
                                            .sId
                                            .toString());
                                  },
                                  gameName: gameCategoryList[index]
                                      .categoryName![index].gameCategoryName
                                      .toString(),
                                );
                              },
                              childCount: gameCategoryList.length,
                            ),
                          ),
                        ),

                        // Add some bottom padding
                        SliverPadding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom + 16,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  listOfGameCategory() async {
    setState(() {
      isLoading = true;
    });

    String? languageTypeId = await _pref.getLanguageId();
    String? userId = await _pref.getChildId();
    Map<String, dynamic> requestData = {};

    Resource resource = await _gameCategoryUsecase.gameCategoryList(
        requestData: requestData,
        id: languageTypeId.toString(),
        userId: userId.toString());

    if (resource.status == STATUS.SUCCESS) {
      gameCategoryList = (resource.data as List)
          .map((x) => GameCategoryModel.fromJson(x))
          .toList();
      // gameList = (resource.data["games"] as List)
      //     .map((x) => Game.fromJson(x))
      //     .toList();


      // languageListId.clear();
      // for (var item in languageList) {
      //   String languageName =
      //   "${item.languageName ?? ""} "
      //       .trim();
      //   String? languageId = item.sId;
      //   if (languageId != null) {
      //     languageListId[languageName] = languageId;
      //   }
      // }

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      CommonUtils().flutterSnackBar(
          context: context, mes: resource.message ?? "", messageType: 4);
    }
  }

  listOfGameByCategory(String categoryId) async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {};

    Resource resource = await _gameCategoryUsecase.gameListByCategory(
      requestData: requestData,
      id: categoryId,
    );

    if (resource.status == STATUS.SUCCESS) {
      gameListByCategory = (resource.data as List)
          .map((x) => GameListModel.fromJson(x))
          .toList();
      Navigator.pushNamed(
        context,
        "/GamePlayNavbarScreen",
        arguments: gameListByCategory,
      );
      // languageListId.clear();
      // for (var item in languageList) {
      //   String languageName =
      //   "${item.languageName ?? ""} "
      //       .trim();
      //   String? languageId = item.sId;
      //   if (languageId != null) {
      //     languageListId[languageName] = languageId;
      //   }
      // }

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      CommonUtils().flutterSnackBar(
          context: context, mes: resource.message ?? "", messageType: 4);
    }
  }
}
