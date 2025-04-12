import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class OverviewScreenWidget extends StatelessWidget {
  final String iconPath;
  final Color iconContainerBgColor;
  final String containerName;
  final String containerDescription;
  const OverviewScreenWidget({super.key, required this.iconPath, required this.iconContainerBgColor, required this.containerName, required this.containerDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils().screenWidth(context) * 0.43,
      height: ScreenUtils().screenHeight(context)*0.16,
      decoration: BoxDecoration(
        color: Colors.white,
        //borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],

      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: iconContainerBgColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.13),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(iconPath,
                height: ScreenUtils().screenHeight(context)*0.03,
                  width: ScreenUtils().screenHeight(context)*0.04,
                ),
                const SizedBox(width: 6),
                Text(
                  containerName,
                  style: TextStyle(
                    fontFamily: "comic_neue",
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              containerDescription,
              style: TextStyle(
                fontFamily: "comic_neue",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.colorBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
