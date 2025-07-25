import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/child_dashboard/widgets/child_dashboard_progress_container.dart';
import 'package:spelling_bee/features/child_dashboard/widgets/dashboard_circular_progress_widget.dart';

import '../../../core/network/apiHelper/locator.dart';
import '../../../core/services/localStorage/shared_pref.dart';
import '../../../core/utils/commonWidgets/custom_buttom_navigation.dart';
import '../widgets/achievement_section.dart';
import '../widgets/child_dashboard_header.dart';
import '../widgets/child_dashboard_header_widget.dart';
import '../widgets/dashboard_match_letter_section.dart';
import '../widgets/explore_play_container.dart';
import '../widgets/game_on_container.dart';
import '../widgets/learning_category_container.dart';
import '../widgets/learning_status_section.dart';
import '../widgets/practice_game_section.dart';
import 'bottom_nav_bar.dart';

class ChildDashboardScreen extends StatefulWidget {
  const ChildDashboardScreen({super.key});

  @override
  State<ChildDashboardScreen> createState() => _ChildDashboardScreenState();
}

class _ChildDashboardScreenState extends State<ChildDashboardScreen> {

  final SharedPref _pref = getIt<SharedPref>();
   String childName="";


   @override
  void initState() {
    super.initState();
    userData();
  }

  void userData() async {
    String? name = await _pref.getUserName();
    setState(() {
      childName = name ?? "";
    });
  }



  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          //physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ChildDashboardHeaderWidget(name: childName,),
              Padding(
                padding: EdgeInsets.all(AppDimensions.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChildDashboardProgressContainer(),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.02,
                    ),
                    ChildDashboardHeader(
                      headerName: 'Explore & Play',
                    ),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.02,
                    ),
                    ExplorePlayContainer(
                      onAlphabetClicked: (){
                        Navigator.pushNamed(context, "/ExploreAndPlayScreen");

                      },
                      onNumberWidget: (){
                        Navigator.pushNamed(context, "/ExploreAndPlayNumberScreen");

                      },
                    ),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChildDashboardHeader(
                          headerName: 'Games Category',
                        ),
                        InkWell(
                          onTap: (){
                            BottomNavBarState.of(context)?.onItemTapped(1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.exploreCardColor,
                              borderRadius: BorderRadius.circular(11),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.colorBlack.withOpacity(0.25), // Shadow color
                                  blurRadius: 4, // Blur radius
                                  offset: Offset(0, 4), // Horizontal and vertical offset
                                  spreadRadius: 0, // How much the shadow will spread
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: ScreenUtils().screenWidth(context)*0.02,
                                  vertical: ScreenUtils().screenWidth(context)*0.01

                              ),
                              child: Row(
                                children: [
                                  Text("See More", style: TextStyle(
                                      fontFamily: "comic_neue",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.white
                                  ),),
                                  Image.asset(
                                    "assets/images/right_arrow.png",
                                    height: ScreenUtils().screenHeight(context)*0.03,
                                    width: ScreenUtils().screenWidth(context)*0.1,
                                    fit: BoxFit.contain, // This makes the image cover the entire area of the circle
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.02,
                    ),
                    PracticeGameSection(),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.02,
                    ),
                    GameOnContainer(),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.02,
                    ),
                    ChildDashboardHeader(
                      headerName: 'Let’s Match Letters & Words!',
                    ),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.02,
                    ),
                    DashboardMatchLetterSection(),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.02,
                    ),

                  ],
                ),
              ),

              // Stack(
              //   children: [
              //     Image.asset("assets/images/dashbord_background.png",
              //     width: ScreenUtils().screenWidth(context),
              //     height: ScreenUtils().screenHeight(context)*0.7,
              //       fit: BoxFit.cover,
              //     ),
              //     Padding(
              //       padding:  EdgeInsets.all(ScreenUtils().screenWidth(context)*0.04),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Container(
              //             width: ScreenUtils().screenWidth(context),
              //             decoration: BoxDecoration(
              //               color: AppColors.dashboardContainerBackgroundColor,
              //               borderRadius: BorderRadius.circular(10)
              //             ),
              //             child:Padding(
              //               padding:  EdgeInsets.all(ScreenUtils().screenWidth(context)*0.04),
              //               child: Column(
              //                 children: [
              //                   Container(
              //                     width:ScreenUtils().screenWidth(context),
              //                     decoration: BoxDecoration(
              //                         color: AppColors.white,
              //                         borderRadius: BorderRadius.circular(10)
              //                     ),
              //                     child: Padding(
              //                       padding:  EdgeInsets.symmetric(
              //                         horizontal: ScreenUtils().screenWidth(context)*0.04,
              //                         vertical: ScreenUtils().screenHeight(context)*0.01
              //                       ),
              //                       child: Row(
              //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                         children: [
              //                           Text("Progress Status", style: TextStyle(
              //                             fontWeight: FontWeight.w400,
              //                             color: AppColors.colorBlack,
              //                             fontSize: 16,
              //                             fontFamily: "Kavoon"
              //                           ),),
              //                           DashboardCircularProgressWidget()
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
              //                   Container(
              //                     width:ScreenUtils().screenWidth(context),
              //                     decoration: BoxDecoration(
              //                         color: AppColors.white,
              //                         borderRadius: BorderRadius.circular(10)
              //                     ),
              //                     child: Padding(
              //                       padding:  EdgeInsets.symmetric(
              //                           horizontal: ScreenUtils().screenWidth(context)*0.04,
              //                           vertical: ScreenUtils().screenHeight(context)*0.01
              //                       ),
              //                       child: Column(
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           Text("Daily Streak", style: TextStyle(
              //                               fontWeight: FontWeight.w400,
              //                               color: AppColors.colorBlack,
              //                               fontSize: 16,
              //                               fontFamily: "Kavoon"
              //                           ),),
              //                           SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
              //                           SizedBox(
              //                             width: ScreenUtils().screenWidth(context), // Fixed width for the progress bar
              //                             child: LinearProgressIndicator(
              //                               borderRadius: BorderRadius.circular(10),
              //                               value: progress,
              //                               minHeight: 10, // Height of the progress bar
              //                               valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Fill color
              //                               backgroundColor: Colors.grey[300], // Background color
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ),
              //           SizedBox(height: ScreenUtils().screenHeight(context)*0.015,),
              //           Text("Learning Categories", style: TextStyle(
              //             fontFamily: "Kavoon",
              //             fontSize: 17,
              //             fontWeight: FontWeight.w400,
              //             color: AppColors.colorBlack
              //           ),),
              //           SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
              //
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //
              //               LearningCategoryContainer(containerName: 'Alphabets & Spelling', imagePath: 'assets/images/learning_progress_img.png',),
              //               LearningCategoryContainer(containerName: 'Numbers', imagePath: 'assets/images/learning_number.png',)
              //
              //             ],
              //           )
              //         ],
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ));
  }
}
