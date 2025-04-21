import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class ExplorePlayContainer extends StatefulWidget {
  Function()? onAlphabetClicked;
  Function()? onNumberWidget;
   ExplorePlayContainer({super.key, this.onAlphabetClicked, this.onNumberWidget});

  @override
  State<ExplorePlayContainer> createState() => _ExplorePlayContainerState();
}

class _ExplorePlayContainerState extends State<ExplorePlayContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils().screenHeight(context)*0.3,
      width: ScreenUtils().screenWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppColors.dashboardContainerBorderColor),
        color: AppColors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/dashbord_background.png"),
          fit: BoxFit.fill,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorBlack.withOpacity(0.25), // Shadow color
            blurRadius: 4, // Blur radius
            offset: Offset(0, 4), // Horizontal and vertical offset
            spreadRadius: 0, // How much the shadow will spread
          ),
        ],
      ),
      child: Row(
        children: [
          ExplorePlayWidget(
            imageLink: 'assets/images/explore_1.png',
            name: 'Alphabet ',
          onTap: widget.onAlphabetClicked,
          ),
          ExplorePlayWidget(
            imageLink: 'assets/images/explore_2.png',
            name: 'Numbers',
            onTap:widget.onNumberWidget,
          ),
        ],
      ),
      
    );
  }
}


class ExplorePlayWidget extends StatelessWidget {
  final String imageLink;
  final String name;
  Function()? onTap;
   ExplorePlayWidget({super.key, required this.imageLink, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.only(
            left: ScreenUtils().screenWidth(context)*0.05,
            top: ScreenUtils().screenWidth(context)*0.05
        ),
        child: Column(
          children: [
            Container(
              height: ScreenUtils().screenHeight(context)*0.18,
              width: ScreenUtils().screenWidth(context)*0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: AppColors.exploreCardBg,
                image: DecorationImage(
                  image: AssetImage(imageLink),
                  fit: BoxFit.contain,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorBlack.withOpacity(0.25), // Shadow color
                    blurRadius: 4, // Blur radius
                    offset: Offset(0, 4), // Horizontal and vertical offset
                    spreadRadius: 0, // How much the shadow will spread
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
            Text(name, style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: "comic_neue",
              color: AppColors.colorBlack
            ),)
          ],
        ),
      ),
    );
  }
}



