
import 'package:flutter/material.dart';
import 'package:spelling_bee/features/game_category/models/game_list_model.dart';

import '../constants/app_colors.dart';
import '../helper/app_dimensions.dart';
import '../helper/screen_utils.dart';

// class ScrollableGameNavigation extends StatefulWidget {
//   final int selectedIndex;
//   final Function(int) onItemTapped;
//   final List<GameListModel> navItems;
//
//   const ScrollableGameNavigation({
//     super.key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//     required this.navItems,
//   });
//
//   @override
//   State<ScrollableGameNavigation> createState() =>
//       _ScrollableGameNavigationState();
// }
//
// class _ScrollableGameNavigationState extends State<ScrollableGameNavigation> {
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       //_scrollToSelectedItem();
//     });
//   }
//
//   @override
//   void didUpdateWidget(covariant ScrollableGameNavigation oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selectedIndex != widget.selectedIndex) {
//      // _scrollToSelectedItem();
//     }
//   }
//
//   // void _scrollToSelectedItem() {
//   //   final itemWidth =
//   //       ScreenUtils().screenHeight(context) * 0.075 + 12; // Icon size + padding
//   //   int index =
//   //       widget.navItems.indexWhere((item) => item.id == widget.selectedIndex);
//   //   if (index != -1) {
//   //     final scrollPosition = index * itemWidth;
//   //     _scrollController.animateTo(
//   //       scrollPosition,
//   //       duration: const Duration(milliseconds: 300),
//   //       curve: Curves.easeInOut,
//   //     );
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     AppDimensions.init(context);
//
//     return Padding(
//       padding: EdgeInsets.only(
//         left: AppDimensions.screenPadding,
//         right: AppDimensions.screenPadding,
//         bottom: AppDimensions.screenPadding,
//       ),
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             height: ScreenUtils().screenHeight(context) * 0.12,
//             decoration: BoxDecoration(
//               color: const Color(0xFFFFFFE0),
//               borderRadius: const BorderRadius.all(Radius.circular(20)),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Color(0xFFFFED8C),
//                   offset: Offset(0, 4),
//                   blurRadius: 0,
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               controller: _scrollController,
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               child: Row(
//                 children: [
//                   Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       child: GestureDetector(
//                         onTap: (){
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           width: ScreenUtils().screenHeight(context) * 0.075,
//                           height: ScreenUtils().screenHeight(context) * 0.075,
//                           decoration: BoxDecoration(
//                             color: AppColors.navbarItemColor.withOpacity(0.74),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(10.0),
//                             child: CircleAvatar(
//                                 backgroundColor: AppColors.white,
//                                 child: Icon(
//                                   Icons.arrow_back,
//                                   color: AppColors.navbarItemColor,
//                                 )),
//                           ),
//                         ),
//                       )),
//                   ...widget.navItems.map((item) => _buildNavItem(
//                         iconPath: "assets/images/level_1.png",
//                         index: 1,
//                         label: item.gameName.toString(),
//                         context: context,
//                       )),
//                 ],
//               ),
//             ),
//
//             // SingleChildScrollView(
//             //   controller: _scrollController,
//             //   scrollDirection: Axis.horizontal,
//             //   physics: const BouncingScrollPhysics(),
//             //   child: Padding(
//             //     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             //     child: Row(
//             //       children: widget.navItems
//             //           .map((item) => _buildNavItem(
//             //         iconPath: item.imagePath,
//             //         index: item.id,
//             //         label: item.name,
//             //         context: context,
//             //       ))
//             //           .toList(),
//             //     ),
//             //   ),
//             // ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavItem({
//     required String iconPath,
//     required int index,
//     required String label,
//     required BuildContext context,
//   }) {
//     final bool isSelected = widget.selectedIndex == index;
//
//     return GestureDetector(
//       onTap: () => widget.onItemTapped(index),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 6.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: isSelected ? 0 : 10),
//               width: ScreenUtils().screenHeight(context) * 0.075,
//               height: ScreenUtils().screenHeight(context) * 0.075,
//               decoration: BoxDecoration(
//                 color: AppColors.navbarItemColor.withOpacity(0.74),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: isSelected
//                     ? [
//                         BoxShadow(
//                           color: AppColors.navbarItemColorDown,
//                           offset: const Offset(0, 6),
//                           blurRadius: 0,
//                         )
//                       ]
//                     : [],
//               ),
//               child: Center(
//                 child: Image.asset(
//                   iconPath,
//                   width: ScreenUtils().screenHeight(context) * 0.06,
//                   height: ScreenUtils().screenHeight(context) * 0.06,
//                 ),
//               ),
//             ),
//             SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
//             if (isSelected)
//               Text(
//                 label.length > 10 ? label.substring(0, 10) : label,
//                 style: TextStyle(
//                   fontFamily: 'Kavoon',
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.navbarItemColor.withOpacity(0.74),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class ScrollableGameNavigation extends StatefulWidget {
  final Function(String) onItemTapped;
  final List<GameListModel> navItems;

  const ScrollableGameNavigation({
    super.key,
    required this.onItemTapped,
    required this.navItems,
  });

  @override
  State<ScrollableGameNavigation> createState() =>
      _ScrollableGameNavigationState();
}

class _ScrollableGameNavigationState extends State<ScrollableGameNavigation> {
  final ScrollController _scrollController = ScrollController();
  late String selectedGameId;

  @override
  void initState() {
    super.initState();
    // Default to first game ID when screen loads
    selectedGameId = widget.navItems.first.sId.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onItemTapped(selectedGameId);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);

    return Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.screenPadding,
        right: AppDimensions.screenPadding,
        bottom: AppDimensions.screenPadding,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: ScreenUtils().screenHeight(context) * 0.12,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFE0),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFFFED8C),
                  offset: Offset(0, 4),
                  blurRadius: 0,
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: ScreenUtils().screenHeight(context) * 0.075,
                        height: ScreenUtils().screenHeight(context) * 0.075,
                        decoration: BoxDecoration(
                          color: AppColors.navbarItemColor.withOpacity(0.74),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.navbarItemColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ...widget.navItems.map((item) => _buildNavItem(
                    iconPath: "assets/images/level_1.png",
                    id: item.sId.toString(),
                    label: item.gameName.toString(),
                    context: context,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    required String id,
    required String label,
    required BuildContext context,
  }) {
    final bool isSelected = selectedGameId == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGameId = id;
        });
        widget.onItemTapped(id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: isSelected ? 0 : 10),
              width: ScreenUtils().screenHeight(context) * 0.075,
              height: ScreenUtils().screenHeight(context) * 0.075,
              decoration: BoxDecoration(
                color: AppColors.navbarItemColor.withOpacity(0.74),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: AppColors.navbarItemColorDown,
                    offset: const Offset(0, 6),
                    blurRadius: 0,
                  )
                ]
                    : [],
              ),
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: ScreenUtils().screenHeight(context) * 0.06,
                  height: ScreenUtils().screenHeight(context) * 0.06,
                ),
              ),
            ),
            SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
            if (isSelected)
              Text(
                label.length > 10 ? label.substring(0, 10) : label,
                style: TextStyle(
                  fontFamily: 'Kavoon',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.navbarItemColor.withOpacity(0.74),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
