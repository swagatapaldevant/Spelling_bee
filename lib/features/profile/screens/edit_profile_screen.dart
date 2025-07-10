import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:spelling_bee/core/network/apiHelper/locator.dart';
import 'package:spelling_bee/core/network/apiHelper/resource.dart';
import 'package:spelling_bee/core/network/apiHelper/status.dart';
import 'package:spelling_bee/core/services/localStorage/shared_pref.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_searchable_dropdown.dart';
import 'package:spelling_bee/core/utils/commonWidgets/custom_date_picker_field.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/common_utils.dart';
import 'package:spelling_bee/features/auth/data/auth_usecase.dart';
import 'package:spelling_bee/features/auth/models/country_list_model.dart';
import 'package:spelling_bee/features/auth/models/mother_language_model.dart';
import 'package:spelling_bee/features/profile/model/profile_data_model.dart';

import '../../../core/utils/commonWidgets/common_button.dart';
import '../../../core/utils/commonWidgets/custom_dropdown.dart';
import '../../../core/utils/commonWidgets/custom_textField.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/helper/screen_utils.dart';
import '../widgets/profile_header.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileDataModel profileData;

  const EditProfileScreen({super.key, required this.profileData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //final TextEditingController phController = TextEditingController();
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

  String selectedDate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfMotherLanguage();
    listOfCountry();
    nameController.text = widget.profileData.name.toString();
    selectedDate = widget.profileData.yearOfBirth.toString();
    selectedLanguage = widget.profileData.motherTongue.toString();
  }


  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.screenPadding),
            child: Column(
              children: [
                ProfileHeader(
                  isBackIcon: true,
                  headerName: "Edit Profile",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.03,
                ),
                Container(
                  height: ScreenUtils().screenHeight(context) * 0.15,
                  width: ScreenUtils().screenHeight(context) * 0.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: AppColors.colorBlack.withOpacity(0.25),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Padding(
                      padding: EdgeInsets.all(8.0), // optional spacing inside
                      child: Image.asset(
                        "assets/images/profile_img.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.01,
                ),
                Text(
                  widget.profileData.name.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "comic_neue",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorBlack),
                ),
                Text(
                  widget.profileData.email.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "comic_neue",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.forgotPasswordColor),
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.02,
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
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.screenPadding),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: nameController,
                          hintText: 'Enter your name',
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.02,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Enter new password',
                          prefixIcon: Icons.lock,
                        ),
                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.02,
                        ),

                        // CustomTextField(controller:phController , hintText: 'Enter your phone', prefixIcon: Icons.phone,),
                        // SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),

                        CustomDatePickerField(
                          selectedDate: selectedDate,
                          onDateChanged: (String value) {
                            setState(() {
                              selectedDate = value;
                            });
                          },
                          placeholderText: 'Select your DOB',
                        ),

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
                        SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.02,
                        ),

                        isLoading? CircularProgressIndicator(
                          color: AppColors.progressBarColor,
                        ):CommonButton(
                          onTap: () {
                            updateProfile();
                          },
                          fontSize: 14,
                          height: ScreenUtils().screenHeight(context) * 0.04,
                          width: ScreenUtils().screenWidth(context) * 0.5,
                          buttonColor: AppColors.welcomeButtonColor,
                          buttonName: 'Update Your Profile ',
                          buttonTextColor: AppColors.white,
                          gradientColor1: Color(0xffc66d32),
                          gradientColor2: Color(0xfffed402),
                          // icon: Icons.play_arrow,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  updateProfile() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {
      "email": widget.profileData.email,
      "name": nameController.text.toString(),
      "password": passwordController.text.toString(),
      "yearOfBirth": widget.profileData.yearOfBirth,
      "motherTongue": widget.profileData.motherTongue,
      "country": widget.profileData.country,
      "city": widget.profileData.city
    };

    Resource resource = await _authUsecase.updateProfile(
      requestData: requestData,
      id: widget.profileData.sId.toString(),
    );

    if (resource.status == STATUS.SUCCESS) {
      CommonUtils().flutterSnackBar(
          context: context,
          mes: "Profile Updated Successfully",
          messageType: 1);
      Navigator.pop(context);

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
