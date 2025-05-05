
import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  bool? isBackIcon;
  bool? isSettingIcon;
  Function()? onTap;
  final String headerName;
   ProfileHeader({super.key, this.isBackIcon, this.isSettingIcon, this.onTap, required this.headerName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Visibility(
           visible: isBackIcon?? false,
           child: InkWell(
               onTap: onTap,
               child: Icon(Icons.arrow_back)),
         ),
        Text(
          headerName,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "comic_neue",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.colorBlack2),
        ),
        Visibility(
            visible: isSettingIcon??false,
            child: Icon(Icons.settings))
      ],
    );
  }
}
