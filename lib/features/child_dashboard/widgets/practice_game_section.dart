import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

import '../../../core/network/apiHelper/locator.dart';
import '../../../core/network/apiHelper/resource.dart';
import '../../../core/network/apiHelper/status.dart';
import '../../../core/services/localStorage/shared_pref.dart';
import '../../../core/utils/helper/common_utils.dart';
import '../../game_category/data/game_category_usecase.dart';
import '../../game_category/models/game_category_model.dart';
import '../../game_category/models/game_list_model.dart';

class PracticeGameSection extends StatefulWidget {
  const PracticeGameSection({super.key});

  @override
  State<PracticeGameSection> createState() => _PracticeGameSectionState();
}

class _PracticeGameSectionState extends State<PracticeGameSection> {
  final GameCategoryUsecase _gameCategoryUsecase = getIt<GameCategoryUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<GameCategoryModel> gameCategoryList = [];
  List<GameListModel> gameListByCategory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfGameCategory();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.containerColor,
            ),
          )
        : SizedBox(
            height: ScreenUtils().screenHeight(context) * 0.15,
            width: ScreenUtils().screenWidth(context),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: gameCategoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: ScreenUtils().screenWidth(context) * 0.05),
                    child: PracticeGameWidget(
                      onPressed: () {
                        listOfGameByCategory(
                            gameCategoryList[index].sId.toString());
                      },
                      imageLink: 'assets/images/level_1.png',
                      level:
                          gameCategoryList[index].gameCategoryName.toString(),
                    ),
                  );
                }),
          );
  }

  listOfGameCategory() async {
    setState(() {
      isLoading = true;
    });

    String? languageTypeId = await _pref.getLanguageId();

    Map<String, dynamic> requestData = {};

    Resource resource = await _gameCategoryUsecase.gameCategoryList(
        requestData: requestData, id: languageTypeId.toString());

    if (resource.status == STATUS.SUCCESS) {
      List<GameCategoryModel> allGames = (resource.data as List)
          .map((x) => GameCategoryModel.fromJson(x))
          .toList();
      gameCategoryList =
          allGames.length > 3 ? allGames.sublist(0, 3) : allGames;

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
      //isLoading = true;
    });

    Map<String, dynamic> requestData = {};

    Resource resource = await _gameCategoryUsecase.gameListByCategory(
        requestData: requestData, id: categoryId);

    if (resource.status == STATUS.SUCCESS) {
      gameListByCategory = (resource.data as List)
          .map((x) => GameListModel.fromJson(x))
          .toList();
      Navigator.pushNamed(
        context, "/GamePlayScreen",
        arguments: gameListByCategory, // Excludes section headers
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

class PracticeGameWidget extends StatelessWidget {
  final String imageLink;
  final String level;
  Function()? onPressed;
  PracticeGameWidget(
      {super.key,
      required this.imageLink,
      required this.level,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Image.asset(
            imageLink,
            height: ScreenUtils().screenHeight(context) * 0.12,
            width: ScreenUtils().screenWidth(context) * 0.25,
          ),
          Text(
            level,
            style: TextStyle(
                fontFamily: "comic_neue",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.dailyStreakColor),
          )
        ],
      ),
    );
  }
}
