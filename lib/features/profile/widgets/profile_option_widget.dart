import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

import '../../../core/utils/constants/app_colors.dart';

class ProfileOptionWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  Function()? onTap;
  bool? isVisible;

   ProfileOptionWidget({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap,
     this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: ScreenUtils().screenWidth(context)*0.03, horizontal: ScreenUtils().screenWidth(context)*0.04),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: ScreenUtils().screenWidth(context)*0.03),
              child: Row(
                children: [
                  Image.asset(iconPath, height: 24, width: 24),
                  SizedBox(width: ScreenUtils().screenWidth(context)*0.03),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: "comic_neue",
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorBlack,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtils().screenWidth(context)*0.03,),
            Visibility(
                visible:isVisible?? true ,
                child: Divider(height: 1)),
          ],
        ),
      ),
    );
  }
}
