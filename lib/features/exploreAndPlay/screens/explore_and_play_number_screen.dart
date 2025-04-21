import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_back_button.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/constants/app_strings_bengali.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/exploreAndPlay/widgets/bengali_word_circle.dart';
import 'package:spelling_bee/features/exploreAndPlay/widgets/explore_screen_button.dart';
import 'package:spelling_bee/features/exploreAndPlay/widgets/learning_game_category_section.dart';

import '../../../core/network/apiHelper/locator.dart';
import '../../../core/network/apiHelper/resource.dart';
import '../../../core/network/apiHelper/status.dart';
import '../../../core/services/localStorage/shared_pref.dart';
import '../../../core/utils/helper/common_utils.dart';
import '../data/explore_play_usecase.dart';
import '../model/alphabet_list_model.dart';
import '../model/learning_alphabet_type.dart';
import '../widgets/explore_play_screen_header.dart';

class ExploreAndPlayNumberScreen extends StatefulWidget {
  const ExploreAndPlayNumberScreen({super.key});

  @override
  State<ExploreAndPlayNumberScreen> createState() => _ExploreAndPlayNumberScreenState();
}

class _ExploreAndPlayNumberScreenState extends State<ExploreAndPlayNumberScreen> {
  final ExplorePlayUsecase _explorePlayUsecase = getIt<ExplorePlayUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  List<LearningAlphabetType> alphabetTypeList = [];
  String vowelId = "";
  String consonantId = "";
  String numericId = "";

  List<AlphabetListModel> alphabetDataList1 = [];
  List<String> allConsonantList = [];

  @override
  void initState() {
    super.initState();
    listOfAlphabetType();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      body: Material(
        color: AppColors.alphabetSafeArea,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                ExplorePlayScreenHeader(),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtils().screenHeight(context) * 0.2,
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/alphabet/alphabet_down_bg.png",
                        width: ScreenUtils().screenWidth(context),
                        fit: BoxFit.cover,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(AppDimensions.screenPadding),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                ScreenUtils().screenHeight(context) * 0.04,
                              ),
                              Text(
                                "Fun with Numbers!",
                                style: TextStyle(
                                    fontFamily: "comic_neue",
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.colorBlack),
                              ),
                              Text(
                                "Choose Your Game",
                                style: TextStyle(
                                    fontFamily: "comic_neue",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.colorBlack),
                              ),
                              SizedBox(
                                height:
                                ScreenUtils().screenHeight(context) * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  LearningGameCategorySection(
                                    onTap:(){
                                      Navigator.pushNamed(context, "/LearningGameButtonNavbar",
                                          arguments: 3
                                      );
                                    },
                                      avatorColor: AppColors
                                          .numberGame4
                                          .withOpacity(0.70),
                                      gameName: 'Match Numbers',
                                      gameDescription:
                                      'Match the number to the group of items',
                                      image:
                                      'assets/images/alphabet/match_number.png'),
                                  // LearningGameCategorySection(
                                  //     avatorColor: AppColors
                                  //         .numberGame3
                                  //         .withOpacity(0.64),
                                  //     gameName: 'Number Order',
                                  //     gameDescription:
                                  //     'Put numbers in the correct order',
                                  //     image:
                                  //     'assets/images/alphabet/number_order.png'),

                                ],
                              ),
                              // SizedBox(
                              //   height:
                              //   ScreenUtils().screenHeight(context) * 0.02,
                              // ),
                              // Row(
                              //   mainAxisAlignment:
                              //   MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     LearningGameCategorySection(
                              //       avatorColor: AppColors.numberGame1
                              //           .withOpacity(0.65),
                              //       gameName: 'Count & Tap',
                              //       gameDescription:
                              //       'Count the items and tap the correct number',
                              //       image:
                              //       'assets/images/alphabet/count_top.png',
                              //     ),
                              //     LearningGameCategorySection(
                              //         avatorColor: AppColors
                              //             .numberGame2
                              //             .withOpacity(0.79),
                              //         gameName: 'Trace the Number',
                              //         gameDescription:
                              //         'Trace numbers with your finger and hear their names',
                              //         image:
                              //         'assets/images/alphabet/trace_number.png')
                              //   ],
                              // ),


                              // SizedBox(
                              //   height:
                              //   ScreenUtils().screenHeight(context) * 0.09,
                              // ),
                              // ExploreScreenButton()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  listOfAlphabetType() async {
    setState(() {
      //isLoading = true;
    });

    String? languageTypeId = await _pref.getLanguageId();
    Map<String, dynamic> requestData = {

    };
    Resource resource =
    await _explorePlayUsecase.learningAlphabetType(requestData: requestData, id: languageTypeId.toString());
    if (resource.status == STATUS.SUCCESS) {
      alphabetTypeList = (resource.data as List)
          .map((x) => LearningAlphabetType.fromJson(x))
          .toList();

      for (var item in alphabetTypeList) {
        if (item.learningName == "Vowel") {
          vowelId = item.sId.toString();
          _pref.setVowelId(vowelId.toString());
        } else if (item.learningName == "Consonants") {
          consonantId = item.sId.toString();
          _pref.setConsonantId(consonantId.toString());
        }else if (item.learningName == "Numeric") {
          numericId = item.sId.toString();
          _pref.setNumericId(numericId.toString());
        }
      }
      setState(() {
        //isLoading = false;
      });
    } else {
      setState(() {
        //isLoading = false;
      });
      CommonUtils().flutterSnackBar(
          context: context, mes: resource.message ?? "", messageType: 4);
    }
  }
}
