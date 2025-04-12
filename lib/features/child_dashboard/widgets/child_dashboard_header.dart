import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';

class ChildDashboardHeader extends StatelessWidget {
  final String headerName;
  const ChildDashboardHeader({super.key, required this.headerName});

  @override
  Widget build(BuildContext context) {
    return Text(headerName, style: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 17,
      fontFamily: "comic_neue",
      color: AppColors.colorBlack

    ),);
  }
}
