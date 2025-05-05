// import 'dart:ui' as ui;
// import 'dart:typed_data';
// import 'package:confetti/confetti.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//
// class AchievementScreen extends StatefulWidget {
//   final String letter;
//   const AchievementScreen({super.key, required this.letter});
//
//   @override
//   State<AchievementScreen> createState() => _AchievementScreenState();
// }
//
// class _AchievementScreenState extends State<AchievementScreen> {
//   final GlobalKey _repaintKey = GlobalKey();
//   String selectedLetter = 'D';
//   List<ui.Image> puzzlePieces = [];
//   List<int?> placedIndexes = [null, null, null, null];
//   bool showHint = true;
//   bool isImageLoaded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => generatePuzzle());
//   }
//
//   Future<void> generatePuzzle() async {
//     RenderRepaintBoundary boundary =
//     _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     ui.Image fullImage = await boundary.toImage(pixelRatio: 3.0);
//     ByteData? byteData = await fullImage.toByteData(format: ui.ImageByteFormat.rawRgba);
//
//     if (byteData != null) {
//       Uint8List data = byteData.buffer.asUint8List();
//       int width = fullImage.width;
//       int height = fullImage.height;
//       int halfWidth = width ~/ 2;
//       int halfHeight = height ~/ 2;
//
//       List<ui.Image> parts = [];
//       for (int row = 0; row < 2; row++) {
//         for (int col = 0; col < 2; col++) {
//           final recorder = ui.PictureRecorder();
//           final canvas = Canvas(recorder);
//           final paint = Paint();
//           canvas.drawImageRect(
//             fullImage,
//             Rect.fromLTWH(col * halfWidth.toDouble(), row * halfHeight.toDouble(),
//                 halfWidth.toDouble(), halfHeight.toDouble()),
//             Rect.fromLTWH(0, 0, halfWidth.toDouble(), halfHeight.toDouble()),
//             paint,
//           );
//           final partImage = await recorder.endRecording().toImage(halfWidth, halfHeight);
//           parts.add(partImage);
//         }
//       }
//
//       parts.shuffle(); // Shuffle for gameplay
//       setState(() {
//         puzzlePieces = parts;
//         placedIndexes = [null, null, null, null]; // Reset placed indexes
//         isImageLoaded = true;
//       });
//     }
//   }
//
//   void checkCorrect() {
//     if (List.generate(4, (i) => i).every((i) => placedIndexes[i] == i)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Correct!')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const double pieceSize = 100;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Visual Letter Puzzle"),
//         leading: BackButton(),
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 16),
//           DropdownButton<String>(
//             value: selectedLetter,
//             onChanged: (value) {
//               setState(() {
//                 selectedLetter = value!;
//                 puzzlePieces = [];
//                 isImageLoaded = false;
//               });
//               WidgetsBinding.instance
//                   .addPostFrameCallback((_) => generatePuzzle());
//             },
//             items: List.generate(
//               26,
//                   (i) => String.fromCharCode(65 + i),
//             ).map((letter) {
//               return DropdownMenuItem(
//                 value: letter,
//                 child: Text("Choose Letter: $letter"),
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 16),
//           Center(
//             child: Stack(
//               children: [
//                 // Faint hint
//                 if (showHint && isImageLoaded)
//                   Opacity(
//                     opacity: 0.2,
//                     child: RepaintBoundary(
//                       key: _repaintKey,
//                       child: Container(
//                         width: pieceSize * 2,
//                         height: pieceSize * 2,
//                         color: Colors.grey[300],
//                         child: Center(
//                           child: Text(
//                             selectedLetter,
//                             style: TextStyle(
//                               fontSize: 150,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 // Drop targets
//                 Container(
//                   width: pieceSize * 2,
//                   height: pieceSize * 2,
//                   child: GridView.builder(
//                     itemCount: 4,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                     ),
//                     itemBuilder: (context, index) {
//                       return DragTarget<int>(
//                         onAccept: (data) {
//                           setState(() {
//                             placedIndexes[index] = data;
//                           });
//                           checkCorrect();
//                         },
//                         builder: (context, candidate, rejected) {
//                           final pieceIndex = placedIndexes[index];
//                           return Container(
//                             margin: EdgeInsets.all(2),
//                             color: Colors.grey[200],
//                             width: pieceSize,
//                             height: pieceSize,
//                             child: pieceIndex != null
//                                 ? Image.memory(
//                               Uint8List.fromList(
//                                   puzzlePieces[pieceIndex].toByteData()!
//                                       .buffer
//                                       .asUint8List()),
//                               width: pieceSize,
//                               height: pieceSize,
//                             )
//                                 : null,
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: List.generate(puzzlePieces.length, (index) {
//               if (placedIndexes.contains(index)) return SizedBox.shrink();
//               return Draggable<int>(
//                 data: index,
//                 feedback: Material(
//                   child: Image.memory(
//                     Uint8List.fromList(
//                         puzzlePieces[index].toByteData()!
//                             .buffer
//                             .asUint8List()),
//                     width: pieceSize,
//                     height: pieceSize,
//                   ),
//                 ),
//                 childWhenDragging: Container(
//                   width: pieceSize,
//                   height: pieceSize,
//                   color: Colors.grey[300],
//                 ),
//                 child: Image.memory(
//                   Uint8List.fromList(
//                       puzzlePieces[index].toByteData()!
//                           .buffer
//                           .asUint8List()),
//                   width: pieceSize,
//                   height: pieceSize,
//                 ),
//               );
//             }),
//           ),
//           SizedBox(height: 20),
//           TextButton(
//             onPressed: () {
//               setState(() => showHint = !showHint);
//             },
//             child: Text(showHint ? "Hide Hint" : "Show Hint"),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class PuzzlePiece {
//   final String id;
//   final Widget widget;
//
//   PuzzlePiece({required this.id, required this.widget});
// }