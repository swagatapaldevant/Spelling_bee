// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:spelling_bee/features/exploreAndPlay/model/match_letter_quiz_model.dart';
//
// class BengaliLetterGameTextPage extends StatefulWidget {
//   const BengaliLetterGameTextPage({super.key});
//
//   @override
//   _BengaliLetterGameTextPageState createState() => _BengaliLetterGameTextPageState();
// }
//
// class _BengaliLetterGameTextPageState extends State<BengaliLetterGameTextPage> {
//   int currentIndex = 0;
//   final FlutterTts flutterTts = FlutterTts();
//
//   final Map<String, String> letterPronunciations = {
//     'অ': 'অ, অকার',
//     'আ': 'আ, আকার',
//     'ই': 'ই, ইকার',
//     'ঈ': 'ঈ, ঈকার',
//     'উ': 'উ, উকার',
//     'ঊ': 'ঊ, ঊকার',
//     'ঋ': 'ঋ, ঋকার',
//     'এ': 'এ, একার',
//     'ঐ': 'ঐ, ঐকার',
//     'ও': 'ও, ওকার',
//     'ঔ': 'ঔ, ঔকার',
//     'ক': 'ক, যেমন কাক',
//     'খ': 'খ, যেমন খাতা',
//     'গ': 'গ, যেমন গামলা',
//     'ঘ': 'ঘ, যেমন ঘর',
//     'ঙ': 'ঙ, যেমন আঁচ',
//     'চ': 'চ, যেমন চাঁদ',
//     'ছ': 'ছ, যেমন ছাতা',
//     'জ': 'জ, যেমন জাম',
//     'ঝ': 'ঝ, যেমন ঝুড়ি',
//     'ঞ': 'ঞ, যেমন বাঞ্জ',
//     'ট': 'ট, যেমন টেবিল',
//     'ঠ': 'ঠ, যেমন ঠেলা',
//     'ড': 'ড, যেমন ডাল',
//     'ঢ': 'ঢ, যেমন ঢোল',
//     'ণ': 'ণ, যেমন বর্ণ',
//     'ত': 'ত, যেমন তলা',
//     'থ': 'থ, যেমন থালা',
//     'দ': 'দ, যেমন দরজা',
//     'ধ': 'ধ, যেমন ধান',
//     'ন': 'ন, যেমন নাক',
//     'প': 'প, যেমন পাতার',
//     'ফ': 'ফ, যেমন ফুল',
//     'ব': 'ব, যেমন বাড়ি',
//     'ভ': 'ভ, যেমন ভাব',
//     'ম': 'ম, যেমন মাটি',
//     'য': 'য, যেমন যুবক',
//     'র': 'র, যেমন রাস্তা',
//     'ল': 'ল, যেমন লতা',
//     'শ': 'শ, যেমন শরীর',
//     'ষ': 'ষ, যেমন পুষ্প',
//     'স': 'স, যেমন সূর্য',
//     'হ': 'হ, যেমন হাওয়া',
//     'ড়': 'ড়, যেমন গাড়ি',
//     'ঢ়': 'ঢ়, যেমন বড়',
//     'য়': 'য়, যেমন ময়ূর',
//     'ৎ': 'ৎ, যেমন কৎ',
//     'ং': 'ং, যেমন বাংলা',
//     'ঃ': 'ঃ, বিশেষ শব্দ',
//     'ঁ': 'ঁ, চাঁদ এর মতো চিহ্ন',
//   };
//
//   @override
//   void initState() {
//     super.initState();
//     initTts();
//   }
//
//   void initTts() async {
//     await flutterTts.setLanguage("bn-IN"); // Indian Bengali
//     await flutterTts.setSpeechRate(0.45);
//     await flutterTts.setPitch(1.0);
//     await flutterTts.setVolume(1.0);
//     await flutterTts.awaitSpeakCompletion(true);
//   }
//
//   void speakLetter(String letter) async {
//     final pronunciation = letterPronunciations[letter] ?? letter;
//     await flutterTts.speak(pronunciation);
//   }
//
//   void onOptionSelected(String selected) {
//     final current = letterQuestions[currentIndex];
//     if (selected == current.letter) {
//       setState(() {
//         if (currentIndex < letterQuestions.length - 1) {
//           currentIndex++;
//         } else {
//           showDialog(
//             context: context,
//             builder: (_) => AlertDialog(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               backgroundColor: Colors.lightGreen[100],
//               title: Text("🎉 বাহ! খুব ভালো!", style: TextStyle(fontSize: 24)),
//               content: Text("তুমি সব বর্ণ শিখে ফেলেছো! 🥳"),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     setState(() => currentIndex = 0);
//                   },
//                   child: Text("আবার খেলো", style: TextStyle(fontSize: 18)),
//                 ),
//               ],
//             ),
//           );
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final current = letterQuestions[currentIndex];
//     final options = [...current.options]..shuffle();
//
//     return Scaffold(
//       backgroundColor: Colors.yellow[50],
//       appBar: AppBar(
//         backgroundColor: Colors.orangeAccent,
//         title: Text("বর্ণ খেলা 🎈", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               "এই বর্ণটি কোনটি?",
//               style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.deepOrange),
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.pinkAccent[100],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     current.letter,
//                     style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   SizedBox(width: 16),
//                   IconButton(
//                     icon: Icon(Icons.volume_up_rounded, size: 40, color: Colors.white),
//                     onPressed: () => speakLetter(current.letter),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             ...options.map((option) => Padding(
//               padding: const EdgeInsets.symmetric(vertical: 6.0),
//               child: ElevatedButton(
//                 onPressed: () => onOptionSelected(option),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.blueAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   minimumSize: Size(double.infinity, 70),
//                 ),
//                 child: Text(
//                   option,
//                   style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             )),
//             Spacer(),
//             Text(
//               "বর্ণ ${currentIndex + 1} / ${letterQuestions.length} ✅",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.deepPurple),
//             ),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:spelling_bee/core/utils/constants/app_colors.dart';
// import 'package:spelling_bee/core/utils/constants/app_strings_bengali.dart';
// import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
// import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
// import 'package:spelling_bee/features/exploreAndPlay/widgets/question_option_container_widget.dart';
//
// import '../../../core/utils/commonWidgets/common_dialog.dart';
// import '../model/match_letter_quiz_model.dart';
//
// class MatchTheLetterGame extends StatefulWidget {
//   const MatchTheLetterGame({super.key});
//
//   @override
//   State<MatchTheLetterGame> createState() => _MatchTheLetterGameState();
// }
//
// class _MatchTheLetterGameState extends State<MatchTheLetterGame> {
//
//   int currentIndex = 0;
//    final FlutterTts flutterTts = FlutterTts();
//
//   final Map<String, String> letterPronunciations = {
//     'অ': 'অ, অকার',
//     'আ': 'আ, আকার',
//     'ই': 'ই, ইকার',
//     'ঈ': 'ঈ, ঈকার',
//     'উ': 'উ, উকার',
//     'ঊ': 'ঊ, ঊকার',
//     'ঋ': 'ঋ, ঋকার',
//     'এ': 'এ, একার',
//     'ঐ': 'ঐ, ঐকার',
//     'ও': 'ও, ওকার',
//     'ঔ': 'ঔ, ঔকার',
//     'ক': 'ক, যেমন কাক',
//     'খ': 'খ, যেমন খাতা',
//     'গ': 'গ, যেমন গামলা',
//     'ঘ': 'ঘ, যেমন ঘর',
//     'ঙ': 'ঙ, যেমন আঁচ',
//     'চ': 'চ, যেমন চাঁদ',
//     'ছ': 'ছ, যেমন ছাতা',
//     'জ': 'জ, যেমন জাম',
//     'ঝ': 'ঝ, যেমন ঝুড়ি',
//     'ঞ': 'ঞ, যেমন বাঞ্জ',
//     'ট': 'ট, যেমন টেবিল',
//     'ঠ': 'ঠ, যেমন ঠেলা',
//     'ড': 'ড, যেমন ডাল',
//     'ঢ': 'ঢ, যেমন ঢোল',
//     'ণ': 'ণ, যেমন বর্ণ',
//     'ত': 'ত, যেমন তলা',
//     'থ': 'থ, যেমন থালা',
//     'দ': 'দ, যেমন দরজা',
//     'ধ': 'ধ, যেমন ধান',
//     'ন': 'ন, যেমন নাক',
//     'প': 'প, যেমন পাতার',
//     'ফ': 'ফ, যেমন ফুল',
//     'ব': 'ব, যেমন বাড়ি',
//     'ভ': 'ভ, যেমন ভাব',
//     'ম': 'ম, যেমন মাটি',
//     'য': 'য, যেমন যুবক',
//     'র': 'র, যেমন রাস্তা',
//     'ল': 'ল, যেমন লতা',
//     'শ': 'শ, যেমন শরীর',
//     'ষ': 'ষ, যেমন পুষ্প',
//     'স': 'স, যেমন সূর্য',
//     'হ': 'হ, যেমন হাওয়া',
//     'ড়': 'ড়, যেমন গাড়ি',
//     'ঢ়': 'ঢ়, যেমন বড়',
//     'য়': 'য়, যেমন ময়ূর',
//     'ৎ': 'ৎ, যেমন কৎ',
//     'ং': 'ং, যেমন বাংলা',
//     'ঃ': 'ঃ, বিশেষ শব্দ',
//     'ঁ': 'ঁ, চাঁদ এর মতো চিহ্ন',
//   };
//
//   @override
//   void initState() {
//     super.initState();
//     initTts();
//   }
//
//   void initTts() async {
//     await flutterTts.setLanguage("bn-IN"); // Indian Bengali
//     await flutterTts.setSpeechRate(0.45);
//     await flutterTts.setPitch(1.0);
//     await flutterTts.setVolume(1.0);
//     await flutterTts.awaitSpeakCompletion(true);
//   }
//
//   void speakLetter(String letter) async {
//     final pronunciation = letterPronunciations[letter] ?? letter;
//     await flutterTts.speak(pronunciation);
//   }
//
//   void onOptionSelected(String selected) {
//     final current = letterQuestions[currentIndex];
//
//     if (selected == current.letter) {
//       showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (_) => Dialog(
//           backgroundColor: Colors.transparent,
//           insetPadding: EdgeInsets.zero,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Lottie.asset(
//                 'assets/images/animations/correct.json',
//                 height: ScreenUtils().screenHeight(context)*0.4,
//                 width: ScreenUtils().screenWidth(context)*0.6,
//                 repeat: false,
//                 onLoaded: (composition) {
//                   Future.delayed(composition.duration, () {
//                     Navigator.pop(context);
//                     setState(() {
//                       if (currentIndex < letterQuestions.length - 1) {
//                         currentIndex++;
//                       } else {
//                         showDialog(
//                           context: context,
//                           builder: (_) => AlertDialog(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20)),
//                             backgroundColor: Colors.lightGreen[100],
//                             title: Text("🎉 বাহ! খুব ভালো!",
//                                 style: TextStyle(fontSize: 24)),
//                             content:
//                             Text("তুমি সব বর্ণ শিখে ফেলেছো! 🥳"),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   setState(() => currentIndex = 0);
//                                 },
//                                 child: Text("আবার খেলো",
//                                     style: TextStyle(fontSize: 18)),
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//                     });
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     AppDimensions.init(context);
//     final current = letterQuestions[currentIndex];
//     final options = [...current.options]..shuffle();
//     List<String> shuffledOptions = List.from(letterQuestions[currentIndex].options)..shuffle();
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset("assets/images/match_letter/match_letter_bg.png",
//           width: ScreenUtils().screenWidth(context),
//             height: ScreenUtils().screenHeight(context),
//             fit: BoxFit.fill,
//           ),
//
//
//           Center(
//             child: Container(
//               height: ScreenUtils().screenHeight(context)*0.88,
//               width: ScreenUtils().screenWidth(context)*0.85,
//               decoration: BoxDecoration(
//                   color: AppColors.white.withOpacity(0.85),
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       offset: Offset(0, 4),
//                       blurRadius: 4,
//                       color: AppColors.colorBlack.withOpacity(0.53),
//                     )
//                   ]
//               ),
//               child: Stack(
//                 children: [
//                   Column(
//                     children: [
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: Padding(
//                           padding:  EdgeInsets.only(left: AppDimensions.screenPadding,
//                             top: AppDimensions.screenPadding
//                           ),
//                           child: GestureDetector(
//                             onTap: (){
//                               CommonDialog(
//                                   icon: Icons.close,
//                                   title: "Want to stop the game ?",
//                                   msg: "If you stop the game then the letter matching is starting from first letter Please confirm.",
//                                   activeButtonLabel: "Confirm",
//                                   context: context,
//                                   activeButtonOnClicked: (){
//                                     Navigator.pop(context);
//                                     Navigator.pop(context);
//                                   }
//                               );
//
//                             },
//                             child: Image.asset("assets/images/match_letter/match_letter_back_icon.png",
//                                 height: ScreenUtils().screenHeight(context)*0.07,
//                               width: ScreenUtils().screenWidth(context)*0.15,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                       ),
//                       //SizedBox(height: ScreenUtils().screenHeight(context)*0.06,),
//                       Text("Match The Letter", style: TextStyle(
//                           color: AppColors.colorBlack1,
//                           fontFamily: "comic_neue",
//                           fontSize: 27,
//                           fontWeight: FontWeight.w700
//                       ),),
//                       SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
//
//                       QuestionOptionContainerWidget(
//                         letter: current.letter,
//                         onTap: () => speakLetter(current.letter),
//                       ),
//
//                       Expanded(
//                         child: Padding(
//                           padding:  EdgeInsets.all(AppDimensions.screenPadding),
//                           child: GridView.builder(
//                             itemCount: 4,
//                             padding: const EdgeInsets.all(8), // Optional padding around grid
//                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               mainAxisSpacing: ScreenUtils().screenWidth(context) * 0.05,
//                               crossAxisSpacing: ScreenUtils().screenWidth(context) * 0.05,
//                               childAspectRatio: 1.3,
//                             ),
//                             itemBuilder: (context, index) {
//                               //String option = letterQuestions[currentIndex].options[index];
//                               String option = shuffledOptions[index];
//
//                               return Bounceable(
//                                 onTap: () => onOptionSelected(option), // Replace with your logic
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(16),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         offset: Offset(0, 4),
//                                         blurRadius: 4,
//                                         color: AppColors.colorBlack.withOpacity(0.25),
//                                       )
//                                     ],
//                                   ),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: AppColors.optionContainer, // Your custom background
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       option, // use your letter list here
//                                       style: const TextStyle(
//                                         fontSize: 50,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//
//
//                     ],
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     child: Image.asset("assets/images/match_letter/match_letter_bottom_cn.png",
//                       height: ScreenUtils().screenHeight(context)*0.2,
//                       width: ScreenUtils().screenWidth(context)*0.4,
//                       fit: BoxFit.contain,),
//                   ),
//                   Positioned(
//                     right: ScreenUtils().screenWidth(context)*0.02,
//                     bottom: ScreenUtils().screenWidth(context)*0.02,
//                     child: Image.asset("assets/images/match_letter/match_letter_bottom_nature.png",
//                       height: ScreenUtils().screenHeight(context)*0.3,
//                       width: ScreenUtils().screenWidth(context)*0.5,
//                       fit: BoxFit.contain,),
//                   ),
//                 ],
//               ),
//
//
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/constants/app_strings_bengali.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/exploreAndPlay/widgets/question_option_container_widget.dart';

import '../../../core/utils/commonWidgets/common_dialog.dart';
import '../model/match_letter_quiz_model.dart';

class MatchTheLetterGame extends StatefulWidget {
  const MatchTheLetterGame({super.key});

  @override
  State<MatchTheLetterGame> createState() => _MatchTheLetterGameState();
}

class _MatchTheLetterGameState extends State<MatchTheLetterGame> {
  int currentIndex = 0;
  final FlutterTts flutterTts = FlutterTts();
  String? selectedWrongOption;

  final Map<String, String> letterPronunciations = {
    'অ': 'অ, অকার', 'আ': 'আ, আকার', 'ই': 'ই, ইকার', 'ঈ': 'ঈ, ঈকার',
    'উ': 'উ, উকার', 'ঊ': 'ঊ, ঊকার', 'ঋ': 'ঋ, ঋকার', 'এ': 'এ, একার',
    'ঐ': 'ঐ, ঐকার', 'ও': 'ও, ওকার', 'ঔ': 'ঔ, ঔকার', 'ক': 'ক, যেমন কাক',
    'খ': 'খ, যেমন খাতা', 'গ': 'গ, যেমন গামলা', 'ঘ': 'ঘ, যেমন ঘর',
    'ঙ': 'ঙ, যেমন আঁচ', 'চ': 'চ, যেমন চাঁদ', 'ছ': 'ছ, যেমন ছাতা',
    'জ': 'জ, যেমন জাম', 'ঝ': 'ঝ, যেমন ঝুড়ি', 'ঞ': 'ঞ, যেমন বাঞ্জ',
    'ট': 'ট, যেমন টেবিল', 'ঠ': 'ঠ, যেমন ঠেলা', 'ড': 'ড, যেমন ডাল',
    'ঢ': 'ঢ, যেমন ঢোল', 'ণ': 'ণ, যেমন বর্ণ', 'ত': 'ত, যেমন তলা',
    'থ': 'থ, যেমন থালা', 'দ': 'দ, যেমন দরজা', 'ধ': 'ধ, যেমন ধান',
    'ন': 'ন, যেমন নাক', 'প': 'প, যেমন পাতার', 'ফ': 'ফ, যেমন ফুল',
    'ব': 'ব, যেমন বাড়ি', 'ভ': 'ভ, যেমন ভাব', 'ম': 'ম, যেমন মাটি',
    'য': 'য, যেমন যুবক', 'র': 'র, যেমন রাস্তা', 'ল': 'ল, যেমন লতা',
    'শ': 'শ, যেমন শরীর', 'ষ': 'ষ, যেমন পুষ্প', 'স': 'স, যেমন সূর্য',
    'হ': 'হ, যেমন হাওয়া', 'ড়': 'ড়, যেমন গাড়ি', 'ঢ়': 'ঢ়, যেমন বড়',
    'য়': 'য়, যেমন ময়ূর', 'ৎ': 'ৎ, যেমন কৎ', 'ং': 'ং, যেমন বাংলা',
    'ঃ': 'ঃ, বিশেষ শব্দ', 'ঁ': 'ঁ, চাঁদ এর মতো চিহ্ন',
  };

  @override
  void initState() {
    super.initState();
    initTts();
  }

  void initTts() async {
    await flutterTts.setLanguage("bn-IN");
    await flutterTts.setSpeechRate(0.45);
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);
  }

  void speakLetter(String letter) async {
    final pronunciation = letterPronunciations[letter] ?? letter;
    await flutterTts.speak(pronunciation);
  }

  void onOptionSelected(String selected) {
    final current = letterQuestions[currentIndex];

    if (selected == current.letter) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/animations/correct.json',
                height: ScreenUtils().screenHeight(context) * 0.4,
                width: ScreenUtils().screenWidth(context) * 0.6,
                repeat: false,
                onLoaded: (composition) {
                  Future.delayed(composition.duration, () {
                    Navigator.pop(context);
                    setState(() {
                      if (currentIndex < letterQuestions.length - 1) {
                        currentIndex++;
                        selectedWrongOption = null;
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.lightGreen[100],
                            title: Text("🎉 বাহ! খুব ভালো!", style: TextStyle(fontSize: 24)),
                            content: Text("তুমি সব বর্ণ শিখে ফেলেছো! 🥳"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    currentIndex = 0;
                                    selectedWrongOption = null;
                                  });
                                },
                                child: Text("আবার খেলো", style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),
                        );
                      }
                    });
                  });
                },
              ),
            ],
          ),
        ),
      );
    } else {
      setState(() => selectedWrongOption = selected);
      Timer(Duration(milliseconds: 500), () {
        setState(() => selectedWrongOption = null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    final current = letterQuestions[currentIndex];
    final options = [...current.options]..shuffle();

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/match_letter/match_letter_bg.png",
            width: ScreenUtils().screenWidth(context),
            height: ScreenUtils().screenHeight(context),
            fit: BoxFit.fill,
          ),
          Center(
            child: Container(
              height: ScreenUtils().screenHeight(context) * 0.88,
              width: ScreenUtils().screenWidth(context) * 0.85,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: AppColors.colorBlack.withOpacity(0.53),
                  )
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: AppDimensions.screenPadding,
                            top: AppDimensions.screenPadding,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              CommonDialog(
                                icon: Icons.close,
                                title: "Want to stop the game ?",
                                msg:
                                "If you stop the game then the letter matching is starting from first letter Please confirm.",
                                activeButtonLabel: "Confirm",
                                context: context,
                                activeButtonOnClicked: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              );
                            },
                            child: Image.asset(
                              "assets/images/match_letter/match_letter_back_icon.png",
                              height: ScreenUtils().screenHeight(context) * 0.07,
                              width: ScreenUtils().screenWidth(context) * 0.15,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Match The Letter",
                        style: TextStyle(
                          color: AppColors.colorBlack1,
                          fontFamily: "comic_neue",
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                      QuestionOptionContainerWidget(
                        letter: current.letter,
                        onTap: () => speakLetter(current.letter),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(AppDimensions.screenPadding),
                          child: GridView.builder(
                            itemCount: 4,
                            padding: const EdgeInsets.all(8),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: ScreenUtils().screenWidth(context) * 0.05,
                              crossAxisSpacing: ScreenUtils().screenWidth(context) * 0.05,
                              childAspectRatio: 1.3,
                            ),
                            itemBuilder: (context, index) {
                              String option = options[index];
                              return Bounceable(
                                onTap: () => onOptionSelected(option),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: AppColors.colorBlack.withOpacity(0.25),
                                      )
                                    ],
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedWrongOption == option
                                          ? Colors.redAccent
                                          : AppColors.optionContainer,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                                    alignment: Alignment.center,
                                    child: Text(
                                      option,
                                      style: const TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/match_letter/match_letter_bottom_cn.png",
                      height: ScreenUtils().screenHeight(context) * 0.2,
                      width: ScreenUtils().screenWidth(context) * 0.4,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    right: ScreenUtils().screenWidth(context) * 0.02,
                    bottom: ScreenUtils().screenWidth(context) * 0.02,
                    child: Image.asset(
                      "assets/images/match_letter/match_letter_bottom_nature.png",
                      height: ScreenUtils().screenHeight(context) * 0.3,
                      width: ScreenUtils().screenWidth(context) * 0.5,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
