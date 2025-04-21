import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../../../core/network/apiHelper/locator.dart';
import '../../../../core/network/apiHelper/resource.dart';
import '../../../../core/network/apiHelper/status.dart';
import '../../../../core/services/localStorage/shared_pref.dart';
import '../../../../core/utils/commonWidgets/common_button.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/common_utils.dart';
import '../../../../core/utils/helper/screen_utils.dart';
import '../../data/explore_play_usecase.dart';
import '../../model/alphabet_list_model.dart';

class AllNumericScreen extends StatefulWidget {
  const AllNumericScreen({super.key});

  @override
  State<AllNumericScreen> createState() => _AllNumericScreenState();
}

class _AllNumericScreenState extends State<AllNumericScreen> {
  final ExplorePlayUsecase _explorePlayUsecase = getIt<ExplorePlayUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  List<AlphabetListModel> numericDataList = [];
  List<String> allNumericsList = [];
  bool isLoading = false;
  String languageName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localData();
    numericList();
  }

  void localData() async {
    String? language = await _pref.getCurrentLanguageName();
    setState(() {
      languageName = language.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
        backgroundColor: AppColors.parentConcernBg,
        body: Stack(children: [
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
                padding: EdgeInsets.only(
                  top: AppDimensions.screenPadding,
                  left: AppDimensions.screenPadding,
                  right: AppDimensions.screenPadding,
                ),
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.containerColor,
                        ),
                      )
                    : allNumericsList.isEmpty
                        ? Center(
                          child: Text(
                              "Now no numerics are updated ",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontFamily: "comic_neue",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                        )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  //CommonBackButton(),
                                  SizedBox(
                                    width: ScreenUtils().screenWidth(context) *
                                        0.03,
                                  ),
                                  Text(
                                    "$languageName Numerics",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontFamily: "comic_neue",
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    ScreenUtils().screenHeight(context) * 0.03,
                              ),
                              Text(
                                "Numerics",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: "comic_neue",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height:
                                    ScreenUtils().screenHeight(context) * 0.01,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      // Grid of letters
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: allNumericsList.length,
                                        padding: const EdgeInsets.all(12),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                          childAspectRatio: 1,
                                        ),
                                        itemBuilder: (context, index) {
                                          final numeric =
                                              allNumericsList[index];
                                          return Bounceable(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/NumericDetailsScreen',
                                                arguments: {
                                                  "index": index,
                                                  "letterList":
                                                      allNumericsList, // Excludes section headers
                                                },
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.optionContainer,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(0, 4),
                                                    blurRadius: 4,
                                                    color: AppColors.colorBlack
                                                        .withOpacity(0.25),
                                                  ),
                                                ],
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                numeric,
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

                                      SizedBox(
                                          height: ScreenUtils()
                                                  .screenHeight(context) *
                                              0.03),

                                      // Let's Play Game Button
                                      CommonButton(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/MatchLetterVowelGame',
                                              arguments: allNumericsList);
                                        },
                                        fontSize: 18,
                                        height: ScreenUtils()
                                                .screenHeight(context) *
                                            0.06,
                                        width:
                                            ScreenUtils().screenWidth(context),
                                        buttonColor:
                                            AppColors.welcomeButtonColor,
                                        buttonName: 'Let\'s Play Game',
                                        buttonTextColor: AppColors.white,
                                        gradientColor1: const Color(0xffc66d32),
                                        gradientColor2: const Color(0xfffed402),
                                        icon: Icons.play_arrow,
                                      ),

                                      SizedBox(
                                          height: ScreenUtils()
                                                  .screenHeight(context) *
                                              0.15),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          )
        ]));
  }

  numericList() async {
    setState(() {
      isLoading = true;
    });
    String? numericId = await _pref.getNumericId();
    Map<String, dynamic> requestData = {};
    Resource resource = await _explorePlayUsecase.bengaliAlphabetList(
        requestData: requestData, id: numericId);
    if (resource.status == STATUS.SUCCESS) {
      numericDataList = (resource.data as List)
          .map((x) => AlphabetListModel.fromJson(x))
          .toList();

      for (var item in numericDataList) {
        allNumericsList.add(item.learningDetailsName.toString());
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
