import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:spelling_bee/core/network/apiHelper/locator.dart';
import 'package:spelling_bee/core/services/localStorage/shared_pref.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_button.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/common_utils.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/exploreAndPlay/data/explore_play_usecase.dart';
import 'package:spelling_bee/features/exploreAndPlay/model/alphabet_list_model.dart';

import '../../../../core/network/apiHelper/resource.dart';
import '../../../../core/network/apiHelper/status.dart';

class AllConsonantScreen extends StatefulWidget {
  const AllConsonantScreen({super.key});

  @override
  State<AllConsonantScreen> createState() => _AllConsonantScreenState();
}

class _AllConsonantScreenState extends State<AllConsonantScreen> {
  final ExplorePlayUsecase _explorePlayUsecase = getIt<ExplorePlayUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  List<AlphabetListModel> alphabetDataList = [];
  List<String> allConsonantList = [];
  bool isLoading = false;
  String languageName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    consonantList();
    localData();
  }

  void localData() async{
    String? language = await _pref.getCurrentLanguageName();
    setState(() {
      languageName = language.toString();
    });

  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return
      Scaffold(
        backgroundColor: AppColors.parentConcernBg,
        body:Stack(
          children: [
          Image.asset(
          "assets/images/alphabet/alphabet_details_bg.jpeg",
          height: ScreenUtils().screenHeight(context),
          width: ScreenUtils().screenWidth(context),
          fit: BoxFit.cover,
        ),
        Container(
          height: ScreenUtils().screenHeight(context),
          width: ScreenUtils().screenWidth(context),
          //color: AppColors.white.withOpacity(0.5),
          color: AppColors.colorBlack.withOpacity(0.5),
          child: SafeArea(
            child: Padding(
              padding:  EdgeInsets.only(
                top:AppDimensions.screenPadding,
                left:AppDimensions.screenPadding,
                right:AppDimensions.screenPadding,

              ),
              child: isLoading?
              Center(
                child: CircularProgressIndicator(
                  color: AppColors.containerColor,
                ),
              ):allConsonantList.isEmpty?
              Center(
                child: Text("Now no Alphabets are updated ", style: TextStyle(
                    color: AppColors.white,
                    fontFamily: "comic_neue",
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                ),),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      //CommonBackButton(),
                      SizedBox(width: ScreenUtils().screenWidth(context)*0.03,),
                      Text("$languageName Alphabets", style: TextStyle(
                          color: AppColors.white,
                          fontFamily: "comic_neue",
                          fontSize: 24,
                          fontWeight: FontWeight.w700
                      ),),
                    ],
                  ),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),

                  Text( "Consonants", style: TextStyle(
                      color: AppColors.white,
                      fontFamily: "comic_neue",
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                  ),),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          // Grid of letters
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: allConsonantList.length,
                            padding: const EdgeInsets.all(12),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) {
                              final letter =allConsonantList[index];
                              return Bounceable(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/ConsonantDetailsScreen',
                                    arguments:{
                                      "index": index,
                                      "letterList":allConsonantList, // Excludes section headers
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.optionContainer,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: AppColors.colorBlack.withOpacity(0.25),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    letter,
                                    style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

                          // Let's Play Game Button
                          CommonButton(
                            onTap: () {
                              Navigator.pushNamed(context, '/MatchLetterVowelGame',
                                  arguments: allConsonantList
                              );
                            },
                            fontSize: 18,
                            height: ScreenUtils().screenHeight(context) * 0.06,
                            width: ScreenUtils().screenWidth(context) ,
                            buttonColor: AppColors.welcomeButtonColor,
                            buttonName: 'Let\'s Play Game',
                            buttonTextColor: AppColors.white,
                            gradientColor1: const Color(0xffc66d32),
                            gradientColor2: const Color(0xfffed402),
                            icon: Icons.play_arrow,
                          ),

                          SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.15,
                          ),                      ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
          ],
        )




      );
  }


consonantList() async {
  setState(() {
    isLoading = true;
  });
  String? consonantId = await _pref.getConsonantId();
  Map<String, dynamic> requestData = {

  };
  Resource resource =
  await _explorePlayUsecase.bengaliAlphabetList(requestData: requestData, id: consonantId);
  if (resource.status == STATUS.SUCCESS) {
    alphabetDataList = (resource.data as List)
        .map((x) => AlphabetListModel.fromJson(x))
        .toList();

    for (var item in alphabetDataList) {
      allConsonantList.add(item.learningDetailsName.toString());
    }

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
