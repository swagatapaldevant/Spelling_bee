import 'package:flutter/material.dart';
import 'package:spelling_bee/core/network/apiHelper/locator.dart';
import 'package:spelling_bee/core/services/localStorage/shared_pref.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

import '../../../core/utils/commonWidgets/common_button.dart';
import '../../../core/utils/constants/app_colors.dart';

class ProfileInfoWidget extends StatefulWidget {
  Function()? onButtonClicked;
   ProfileInfoWidget({super.key, this.onButtonClicked,});

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  final SharedPref _pref = getIt<SharedPref>();
  String language = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData();

  }

  void userData() async {
    String? currentLanguage = await _pref.getCurrentLanguageName();
    setState(() {
      language = currentLanguage ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: ScreenUtils().screenHeight(context) * 0.09,
          width: ScreenUtils().screenHeight(context) * 0.09,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "OLIVER JACKSON",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "comic_neue",
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.colorBlack),
            ),
            RichText(
              text: TextSpan(
                text: 'Age :  ',
                style: TextStyle(
                    fontFamily: "comic_neue",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.colorBlack),
                children: const <TextSpan>[
                  TextSpan(
                      text: '6',
                      style: TextStyle(
                          fontFamily: "comic_neue",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.colorBlack)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Language :  ',
                style: TextStyle(
                    fontFamily: "comic_neue",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.colorBlack),
                children:  <TextSpan>[
                  TextSpan(
                      text: language,
                      style: TextStyle(
                          fontFamily: "comic_neue",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.colorBlack)),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtils().screenHeight(context) * 0.015,
            ),
            CommonButton(
              onTap:widget.onButtonClicked,
              fontSize: 14,
              height: ScreenUtils().screenHeight(context) * 0.04,
              width: ScreenUtils().screenWidth(context) * 0.4,
              buttonColor: AppColors.welcomeButtonColor,
              buttonName: 'Edit Your Profile ',
              buttonTextColor: AppColors.white,
              gradientColor1: Color(0xffc66d32),
              gradientColor2: Color(0xfffed402),
              // icon: Icons.play_arrow,
            ),
          ],
        )
      ],
    );
  }
}
