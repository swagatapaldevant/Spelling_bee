import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:spelling_bee/core/network/apiHelper/locator.dart';
import 'package:spelling_bee/core/network/apiHelper/resource.dart';
import 'package:spelling_bee/core/network/apiHelper/status.dart';
import 'package:spelling_bee/core/services/localStorage/shared_pref.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_searchable_dropdown.dart';
import 'package:spelling_bee/core/utils/commonWidgets/custom_date_picker_field.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/common_utils.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/auth/data/auth_usecase.dart';
import 'package:spelling_bee/features/auth/models/country_list_model.dart';
import 'package:spelling_bee/features/auth/models/mother_language_model.dart';

import '../../../core/utils/commonWidgets/common_button.dart';
import '../../../core/utils/commonWidgets/custom_textField.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController actualNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String? selectedGender;
  String? selectedAge;
  String? selectedDate;
  bool isLoading = false;
  final AuthUsecase _authUsecase = getIt<AuthUsecase>();
  final SharedPref _pref = getIt<SharedPref>();

  List<CountryListModel> countryList = [];
  Map<String, String> country = {};
  late List<MapEntry<String, String>> countryTypeEntries;
  MapEntry<String, String>? selectedCountry;
  String countryName = "";
  String? countryId;

  List<MotherLanguageModel> motherLanguageList = [];
  List<String> listMotherLanguage = [];
  String? selectedLanguage;

  List<String> cityList = [];
  String? selectedCity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfMotherLanguage();
    listOfCountry();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0E6889).withOpacity(0.74), // Top-left orange
              Color(0xFF0E6889).withOpacity(0.74), // Bottom-right yellow
              Color(0xFF003D73).withOpacity(0.73), // Bottom-right yellow
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: AppDimensions.screenPadding,
                    right: AppDimensions.screenPadding,
                    top: ScreenUtils().screenHeight(context) * 0.1,
                    bottom: AppDimensions.screenPadding,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.screenPadding,
                      vertical: ScreenUtils().screenHeight(context) * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Sign-Up",
                          style: TextStyle(
                            fontFamily: "comic_neue",
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: AppColors.progressBarTextColor,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.03,
                        ),
                        CustomTextField(
                          controller: userNameController,
                          hintText: 'Enter your user name',
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.01,
                        ),
                        CustomTextField(
                          controller: actualNameController,
                          hintText: 'Enter your full name',
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.01,
                        ),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Enter your email',
                          prefixIcon: Icons.email,
                        ),
                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.01,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Enter your password',
                          prefixIcon: Icons.lock,
                        ),
                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.02,
                        ),
                        CustomDatePickerField(
                          selectedDate: selectedDate,
                          onDateChanged: (String value) {
                            setState(() {
                              selectedDate = value;
                            });
                          },
                          placeholderText: 'Select your DOB',
                        ),
                        // CustomTextField(controller: ageController, hintText: 'Enter your age', prefixIcon: Icons.person,),
                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.02,
                        ),
                        CommonSearchableDropdown<String>(
                          items: (String filter, LoadProps? props) async {
                            // Simulate search filtering (optional)
                            await Future.delayed(const Duration(
                                milliseconds:
                                    300)); // optional: simulate network
                            return listMotherLanguage
                                .where((item) => item
                                    .toLowerCase()
                                    .contains(filter.toLowerCase()))
                                .toList();
                          },
                          hintText: "Select mother tongue",
                          selectedItem: selectedLanguage,
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value;
                            });
                          },
                          itemAsString: (item) => item,
                        ),

                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.02,
                        ),
                        CommonSearchableDropdown<MapEntry<String, String>>(
                          items: (String filter, LoadProps? props) async {
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            return countryTypeEntries
                                .where((entry) => entry.value
                                    .toLowerCase()
                                    .contains(filter.toLowerCase()))
                                .toList();
                          },
                          hintText: "Select country",
                          selectedItem: selectedCountry,
                          onChanged: (value) {
                            setState(() {
                              selectedCountry = value;
                              countryName = selectedCountry!.value;
                              countryId = selectedCountry?.key;
                              listOfCities();
                            });
                          },
                          itemAsString: (entry) => entry.value,
                          compareFn: (a, b) => a.key == b.key,
                        ),
                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.02,
                        ),
                        countryName == ""
                            ? SizedBox.shrink()
                            : CommonSearchableDropdown<String>(
                                items: (String filter, LoadProps? props) async {
                                  // Simulate search filtering (optional)
                                  await Future.delayed(const Duration(
                                      milliseconds:
                                          300)); // optional: simulate network
                                  return cityList
                                      .where((item) => item
                                          .toLowerCase()
                                          .contains(filter.toLowerCase()))
                                      .toList();
                                },
                                hintText: "Select your city",
                                selectedItem: selectedCity,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCity = value;
                                  });
                                },
                                itemAsString: (item) => item,
                              ),

                        // Text(
                        //   "Gender ",
                        //   style: TextStyle(
                        //     fontFamily: "comic_neue",
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w700,
                        //     color: AppColors.colorBlack.withOpacity(0.65),
                        //   ),
                        // ),
                        // SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                        // _buildGenderOption("Boy"),
                        // SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                        // _buildGenderOption("Girl"),

                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.025,
                        ),

                        // Text(
                        //   "Age ",
                        //   style: TextStyle(
                        //     fontFamily: "comic_neue",
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w700,
                        //     color: AppColors.colorBlack.withOpacity(0.65),
                        //   ),
                        // ),
                        // SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                        // _buildAgeOption("4-6 years"),
                        // SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                        // _buildAgeOption("7-9 years"),
                        // SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                        // _buildAgeOption("10-14 years"),
                        // SizedBox(height: ScreenUtils().screenHeight(context)*0.04,),

                        Center(
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: AppColors.containerColor,
                                )
                              : CommonButton(
                                  onTap: () {
                                    registerChild();
                                  },
                                  fontSize: 16,
                                  height: ScreenUtils().screenHeight(context) *
                                      0.05,
                                  width:
                                      ScreenUtils().screenWidth(context) * 0.6,
                                  buttonColor: AppColors.welcomeButtonColor,
                                  buttonName: 'Create Account',
                                  buttonTextColor: AppColors.white,
                                  gradientColor1: Color(0xffc66d32),
                                  gradientColor2: Color(0xfffed402),
                                ),
                        ),
                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, "/LoginScreen");
                          },
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.forgotPasswordColor,
                                  fontFamily: "comic_neue",
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'Log in here',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppColors.dailyStreakColor,
                                        fontFamily: "comic_neue",
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Image.asset(
                    "assets/images/overview_cn.png",
                    height: ScreenUtils().screenHeight(context) * 0.2,
                    width: ScreenUtils().screenWidth(context) * 0.4,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    final bool isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
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
          SizedBox(width: ScreenUtils().screenWidth(context) * 0.04),
          Text(
            gender,
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

  Widget _buildAgeOption(String age) {
    final bool isSelected = selectedAge == age;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAge = age;
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
          SizedBox(width: ScreenUtils().screenWidth(context) * 0.04),
          Text(
            age,
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

  registerChild() async {
    setState(() {
      isLoading = true;
    });
    //String? instituteId = await _pref.getInstituteId();

    Map<String, dynamic> requestData = {
      "email": emailController.text.trim(),
      "name": userNameController.text.trim(),
      "originalName":actualNameController.text.trim(),
      "userType": "child",
      "password": passwordController.text.trim(),
      "yearOfBirth": selectedDate,
      "motherTongue": selectedLanguage,
      "country": countryName,
      "city": selectedCity
    };

    Resource resource = await _authUsecase.register(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      _pref.setLoginStatus(true);
      _pref.setUserAuthToken(resource.data["token"]);
      _pref.setChildId(resource.data["userData"]["_id"].toString());
      // _pref.setLanguageId(
      //     resource.data["logedInUser"]["language"]["_id"].toString());
      // _pref.setCurrentLanguageName(
      //     resource.data["logedInUser"]["language"]["language_name"].toString());
      _pref.setUserType(resource.data["userData"]["user_type"].toString());
      _pref.setUserName(resource.data["userData"]["name"].toString());

      List<dynamic> consentList = resource.data["userData"]["parent_consent"];
      if (consentList.length == 2 &&
          consentList[0] == true &&
          consentList[1] == true) {
        setState(() {
          isLoading = false;
          Navigator.pushReplacementNamed(context, "/BottomNavBar");
        });
      } else {
        setState(() {
          isLoading = false;
          Navigator.pushReplacementNamed(context, "/ParentConcernScreen");
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(" message is ${resource.message}");
      CommonUtils().flutterSnackBar(
          context: context, mes: resource.message ?? "", messageType: 4);
    }
  }

  listOfMotherLanguage() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {};

    Resource resource =
        await _authUsecase.motherLanguageList(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      motherLanguageList = (resource.data["languages"] as List)
          .map((x) => MotherLanguageModel.fromJson(x))
          .toList();
      for (var item in motherLanguageList) {
        listMotherLanguage.add(item.name.toString());
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

  listOfCountry() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {};

    Resource resource =
        await _authUsecase.countryList(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      countryList = (resource.data["countries"] as List)
          .map((x) => CountryListModel.fromJson(x))
          .toList();
      for (var item in countryList) {
        if (item.shortName != null) {
          country[(item.shortName ?? "")] = item.name ?? "";
        }
      }
      countryTypeEntries = country.entries.toList();
      //selectedCountry = countryTypeEntries.first;

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

  listOfCities() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {};

    Resource resource = await _authUsecase.stateList(
      requestData: requestData,
      id: countryId.toString(),
    );

    if (resource.status == STATUS.SUCCESS) {
      cityList = List<String>.from(resource.data["cities"]);

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
