import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

import '../../../core/network/apiHelper/locator.dart';
import '../../../core/network/apiHelper/resource.dart';
import '../../../core/network/apiHelper/status.dart';
import '../../../core/services/localStorage/shared_pref.dart';
import '../../../core/utils/commonWidgets/common_button.dart';
import '../../../core/utils/commonWidgets/custom_dropdown.dart';
import '../../../core/utils/helper/common_utils.dart';
import '../data/auth_usecase.dart';
import '../models/language_list_model.dart';

class ParentConcernScreen extends StatefulWidget {
  const ParentConcernScreen({super.key});

  @override
  State<ParentConcernScreen> createState() => _ParentConcernScreenState();
}

class _ParentConcernScreenState extends State<ParentConcernScreen> {

  String? selectedValue;
  String? selectedValue1;
  String languageSelection="";
  String? languageSelectionId;
  final AuthUsecase _authUsecase = getIt<AuthUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<LanguageListModel> languageList = [];
  Map<String, String> languageListId = {};

  @override
  void initState() {
    super.initState();
    listOfLanguage();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      backgroundColor: AppColors.parentConcernBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/parent_concern_top.png",
          width: ScreenUtils().screenWidth(context),
          ),
      
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(AppDimensions.screenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dear Parents/Guardians,",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: AppColors.dailyStreakColor,
                            fontFamily: "comic_neue",
                          ),
                        ),

                        Text(
                          "In the conduct of learning online, we are using online conferencing platforms in conducting classes online. We believe that there is no better teaching and learning method than conducting lessons in physical presence and participation of face-to-face interaction. However, during these days, we prioritize everyone's safety.",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.colorBlack.withOpacity(0.64),
                            fontFamily: "comic_neue",
                          ),
                        ),

                        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

                        Text(
                          "We believe that education starts at home and during this experience of online learning, we hope to build a strong partnership with families for a child's ways to learn at home with the help of technologies that allows us to remain in touch, provide instruction, educate, and interact with your child.",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.colorBlack.withOpacity(0.64),
                            fontFamily: "comic_neue",
                          ),
                        ),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

                        Text(
                          "Children's Online Privacy Protection Act (COPPA)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColors.dailyStreakColor,
                            fontFamily: "comic_neue",
                          ),
                        ),

                        Text(
                          "COPPA is a law that deals with how websites and other online operations, including applications, collect data and information from children under the age of 13. In compliance, no advertising shall appear during sessions of online classes.",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.colorBlack.withOpacity(0.64),
                            fontFamily: "comic_neue",
                          ),
                        ),

                        SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),


                        Text(
                          "I hereby give my permission for my child to participate in an online class in a platform preferred by the School",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: AppColors.colorBlack,
                            fontFamily: "comic_neue",
                          ),
                        ),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                        _buildSelectedOption("Yes"),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                        _buildSelectedOption("No"),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),

                        Text(
                          "By affirming my consent for my child to participate in an online class, I understand that no derogatory, obscene, or any form of racism shall be allowed in class.",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: AppColors.colorBlack,
                            fontFamily: "comic_neue",
                          ),
                        ),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

                        _buildSelectedOption1("Yes"),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                        _buildSelectedOption1("No"),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                        Text(
                          "Select your language which you want to learn",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColors.dailyStreakColor,
                            fontFamily: "comic_neue",
                          ),
                        ),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                        CustomDropDownForTaskCreation(
                          data: languageListId,
                          placeHolderText: 'Select One Language',
                          onValueSelected: (String value, String id) {
                            setState(() {
                              languageSelection = value; // Update selected value
                              languageSelectionId = id;
                              _pref.setLanguageId(languageSelectionId??"");
                              _pref.setCurrentLanguageName(languageSelection);
                            });
                          },
                        ),

                        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),



                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Image.asset("assets/images/parent_concern.png",
                        width: ScreenUtils().screenWidth(context),
                        fit: BoxFit.fill,
                      ),
                      Center(
                        child: CommonButton(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "/BottomNavBar");
                          },
                          fontSize: 16,
                          height: ScreenUtils().screenHeight(context) * 0.05,
                          width: ScreenUtils().screenWidth(context) * 0.6,
                          buttonColor: AppColors.welcomeButtonColor,
                          buttonName: 'Submit',
                          buttonTextColor: AppColors.white,
                          gradientColor1: Color(0xffc66d32),
                          gradientColor2: Color(0xfffed402),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

      
      
          
        ],
      ),
    );
  }

  Widget _buildSelectedOption(String v) {
    final bool isSelected = selectedValue== v;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedValue = v;
        });
      },
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? Colors.black : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorBlack.withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: isSelected
                ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
                : null,
          ),
          SizedBox(width: ScreenUtils().screenWidth(context)*0.04),
          Text(
            v,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: "comic_neue",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedOption1(String v) {
    final bool isSelected = selectedValue1== v;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedValue1 = v;
        });
      },
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? Colors.black : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorBlack.withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: isSelected
                ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
                : null,
          ),
          SizedBox(width: ScreenUtils().screenWidth(context)*0.04),
          Text(
            v,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: "comic_neue",
            ),
          ),
        ],
      ),
    );
  }


  listOfLanguage() async {
    setState(() {
      //isLoading = true;
    });

    Map<String, dynamic> requestData = {

    };

    Resource resource =
    await _authUsecase.languageList(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      languageList = (resource.data as List)
          .map((x) => LanguageListModel.fromJson(x))
          .toList();
      languageListId.clear();
      for (var item in languageList) {
        String languageName =
        "${item.languageName ?? ""} "
            .trim();
        String? languageId = item.sId;
        if (languageId != null) {
          languageListId[languageName] = languageId;
        }
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
