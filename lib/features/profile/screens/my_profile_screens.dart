import 'package:flutter/material.dart';
import 'package:spelling_bee/core/network/apiHelper/locator.dart';
import 'package:spelling_bee/core/network/apiHelper/resource.dart';
import 'package:spelling_bee/core/network/apiHelper/status.dart';
import 'package:spelling_bee/core/services/localStorage/shared_pref.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/common_utils.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/auth/data/auth_usecase.dart';
import 'package:spelling_bee/features/auth/models/language_list_model.dart';
import 'package:spelling_bee/features/profile/model/profile_data_model.dart';

import '../../../core/utils/commonWidgets/common_dialog.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_widget.dart';
import '../widgets/profile_option_widget.dart';

class MyProfileScreens extends StatefulWidget {
  const MyProfileScreens({super.key});

  @override
  State<MyProfileScreens> createState() => _MyProfileScreensState();
}

class _MyProfileScreensState extends State<MyProfileScreens> {
  String languageSelection = "";
  String? languageSelectionId;
  final AuthUsecase _authUsecase = getIt<AuthUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<LanguageListModel> languageList = [];
  Map<String, String> languageListId = {};
  String _selectedLanguage = 'English';
  ProfileDataModel? profileData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfLanguage();
    getProfileData();
  }

  // Function to refresh profile data
  void _refreshProfileData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    setState(() {
      getProfileData();
      isLoading = false;
    });
  }

  Future<void> _navigateToEditProfile(ProfileDataModel profileData) async {
    await Navigator.pushNamed(context, "/EditProfileScreen",
        arguments: profileData);
    _refreshProfileData();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: AppDimensions.screenPadding,
            right: AppDimensions.screenPadding,
          ),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.containerColor,
                  ),
                )
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: ScreenUtils().screenHeight(context) * 0.02,
                      ),
                      ProfileHeader(
                        headerName: "My Profile",
                      ),
                      SizedBox(
                        height: ScreenUtils().screenHeight(context) * 0.03,
                      ),
                      ProfileInfoWidget(
                        onButtonClicked: () {
                          _navigateToEditProfile(profileData!);
                        },
                        name: profileData?.name ?? "",
                        city: profileData?.city ?? "",
                      ),
                      SizedBox(
                        height: ScreenUtils().screenHeight(context) * 0.03,
                      ),
                      Container(
                        width: ScreenUtils().screenWidth(context),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.gray3),
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.profileContainerColor,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                              color: AppColors.colorBlack.withOpacity(0.25),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  ScreenUtils().screenHeight(context) * 0.03,
                            ),
                            ProfileOptionWidget(
                                iconPath: "assets/images/profile/star_icon.png",
                                title: "Group creation"),
                            ProfileOptionWidget(
                                iconPath:
                                    "assets/images/profile/badges_icon.png",
                                title: "Goal Plan"),
                            ProfileOptionWidget(
                              iconPath:
                                  "assets/images/profile/language_icon.png",
                              title: "Change Language",
                              onTap: () {
                                _showLanguagePopup();
                              },
                            ),
                            ProfileOptionWidget(
                                iconPath:
                                    "assets/images/profile/reminders_icon.png",
                                title: "Reminders"),
                            ProfileOptionWidget(
                              iconPath: "assets/images/profile/logout_icon.png",
                              title: "Log Out",
                              isVisible: false,
                              onTap: () {
                                CommonDialog(
                                    icon: Icons.logout,
                                    title: "Log Out",
                                    msg:
                                        "You are about to logout of your account. Please confirm.",
                                    activeButtonLabel: "Log Out",
                                    context: context,
                                    activeButtonOnClicked: () {
                                      _pref.clearOnLogout();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        "/WellcomeScreen",
                                        (Route<dynamic> route) =>
                                            false, // Removes all previous routes
                                      );
                                    });
                              },
                            ),
                            SizedBox(
                              height:
                                  ScreenUtils().screenHeight(context) * 0.04,
                            ),
                            Text(
                              "App Version 1.0 — Keep Spelling, Keep Shining! ✨",
                              style: TextStyle(
                                fontFamily: "comic_neue",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.colorBlack,
                              ),
                            ),
                            SizedBox(
                              height:
                                  ScreenUtils().screenHeight(context) * 0.02,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtils().screenHeight(context) * 0.03,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  listOfLanguage() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {};

    Resource resource =
        await _authUsecase.languageList(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      languageList = (resource.data as List)
          .map((x) => LanguageListModel.fromJson(x))
          .toList();
      languageListId.clear();
      for (var item in languageList) {
        String languageName = "${item.languageName ?? ""} ".trim();
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

  void _showLanguagePopup() {
    showDialog(
      context: context,
      builder: (context) {
        String tempSelected = _selectedLanguage;

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxHeight: 400),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Change Language",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "comic_neue",
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: languageList.length,
                          itemBuilder: (context, index) {
                            final language = languageList[index];
                            final langName = language.languageName ?? "";
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                Icons.radio_button_checked,
                                color: Colors.deepPurple,
                              ),
                              title: Text(
                                langName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "comic_neue",
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                _applyLanguage(langName);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  getProfileData() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {};

    Resource resource =
        await _authUsecase.profileData(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      profileData = ProfileDataModel.fromJson(resource.data["logedInUser"]);
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

  void _applyLanguage(String language) async {
    final selectedLanguageId = languageListId[language];

    if (selectedLanguageId != null) {
      _pref.setLanguageId(selectedLanguageId);
      _pref.setCurrentLanguageName(language);
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/BottomNavBar",
        (Route<dynamic> route) => false,
      );

      print("✅ Language saved: $language (ID: $selectedLanguageId)");
    } else {
      print("⚠️ Language ID not found for $language");
    }
  }
}
