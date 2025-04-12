import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';

import '../../../core/utils/commonWidgets/common_back_button.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/helper/screen_utils.dart';
import '../model/match_letter_quiz_model.dart';

class AllBengaliLetterScreen extends StatefulWidget {
  const AllBengaliLetterScreen({super.key});

  @override
  State<AllBengaliLetterScreen> createState() => _AllBengaliLetterScreenState();
}

class _AllBengaliLetterScreenState extends State<AllBengaliLetterScreen> {
  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      backgroundColor: AppColors.parentConcernBg,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(AppDimensions.screenPadding),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CommonBackButton(),
                  SizedBox(width: ScreenUtils().screenWidth(context)*0.03,),
                  Text("Bengali Alphabets", style: TextStyle(
                      color: AppColors.colorBlack,
                      fontFamily: "comic_neue",
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                  ),),
                ],
              ),
              SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
              Expanded(
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: letterQuestions.length,
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final letter = letterQuestions[index].letter;
                    return Bounceable(
                      onTap: () {
                        Navigator.pushNamed(context, "/BengaliLetterDetailScreen", arguments: index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.optionContainer,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: AppColors.colorBlack.withOpacity(0.25),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          letter,
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
