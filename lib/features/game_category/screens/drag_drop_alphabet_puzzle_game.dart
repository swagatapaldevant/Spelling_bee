import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:lottie/lottie.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_button.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/game_category/screens/animated_earned_coined_text.dart';

class DragDropAlphabetPuzzleGame extends StatefulWidget {
  const DragDropAlphabetPuzzleGame({super.key});

  @override
  State<DragDropAlphabetPuzzleGame> createState() =>
      _DragDropAlphabetPuzzleGameState();
}

class _DragDropAlphabetPuzzleGameState
    extends State<DragDropAlphabetPuzzleGame> {
  // Constants
  static const int _pieceCount = 4;
  static const double _pieceSize = 100.0;
  static const double _anotherPieceSize = 60.0;
  static const double _hintOpacity = 0.15;

  // State variables
  late String selectedLetter;
  final GlobalKey _repaintKey = GlobalKey();
  final List<ui.Image> _originalPieces = [];
  final List<ui.Image> _shuffledPieces = [];
  final List<int?> _placedIndexes = List.filled(_pieceCount, null);
  bool _showHint = true;
  bool _isImageLoaded = false;
  bool _isPuzzleSolved = false;
  bool _showSuccessAnimation = false; // New state for animation
  final Random _random = Random();
  int currentIndex = 0;
  List<String> alphabetList = [
    'অ',
    'আ',
    'ই',
    'ঈ',
    'উ',
    'ঊ',
    'ঋ',
    'এ',
    'ঐ',
    'ও',
    'ঔ'
  ];

  @override
  void initState() {
    super.initState();
    selectedLetter = alphabetList[currentIndex];
    currentIndex = alphabetList.indexOf(selectedLetter);
    if (currentIndex == -1) currentIndex = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) => _generatePuzzle());
  }

  Future<Uint8List?> _imageToBytes(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<void> _generatePuzzle() async {
    setState(() {
      _isImageLoaded = false;
      _isPuzzleSolved = false;
      _showSuccessAnimation = false;
      _placedIndexes.fillRange(0, _pieceCount, null);
    });

    await Future.delayed(const Duration(milliseconds: 50));

    final boundary = _repaintKey.currentContext?.findRenderObject()
        as RenderRepaintBoundary?;
    if (boundary == null) return;

    final fullImage = await boundary.toImage(pixelRatio: 3.0);
    final width = fullImage.width;
    final height = fullImage.height;
    final halfWidth = width ~/ 2;
    final halfHeight = height ~/ 2;

    // Generate puzzle pieces
    _originalPieces.clear();
    for (int row = 0; row < 2; row++) {
      for (int col = 0; col < 2; col++) {
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);
        canvas.drawImageRect(
          fullImage,
          Rect.fromLTWH(
            col * halfWidth.toDouble(),
            row * halfHeight.toDouble(),
            halfWidth.toDouble(),
            halfHeight.toDouble(),
          ),
          Rect.fromLTWH(0, 0, halfWidth.toDouble(), halfHeight.toDouble()),
          Paint(),
        );
        _originalPieces
            .add(await recorder.endRecording().toImage(halfWidth, halfHeight));
      }
    }

    // Shuffle pieces
    _shuffledPieces.clear();
    _shuffledPieces.addAll(_originalPieces);
    _shuffledPieces.shuffle(_random);

    setState(() => _isImageLoaded = true);
  }

  void _checkCompletion() {
    bool solved = true;
    for (int i = 0; i < _pieceCount; i++) {
      if (_placedIndexes[i] == null ||
          _shuffledPieces[_placedIndexes[i]!] != _originalPieces[i]) {
        solved = false;
        break;
      }
    }

    if (solved) {
      setState(() {
        _isPuzzleSolved = true;
        _showSuccessAnimation = true; // Show animation
      });

      // Show success message
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text('Puzzle solved! Great job!'),
      //   duration: const Duration(seconds: 1),
      //   behavior: SnackBarBehavior.floating,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      // ));

      // Hide animation after 2 seconds and move to next letter
      // Future.delayed(const Duration(seconds: 2), () {
      //   setState(() => _showSuccessAnimation = false);

        // if (currentIndex < alphabetList.length - 1) {
        //   currentIndex++;
        //   setState(() {
        //     selectedLetter = alphabetList[currentIndex];
        //     _isPuzzleSolved = false;
        //   });
        //   _generatePuzzle();
        // } else {
        //   // All letters completed
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content:
        //           const Text('Congratulations! You completed all letters!'),
        //       duration: const Duration(seconds: 3),
        //       behavior: SnackBarBehavior.floating,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //     ),
        //   );
        // }
      //});
    }

  }

  void _resetPuzzle() {
    setState(() {
      _placedIndexes.fillRange(0, _pieceCount, null);
      _isPuzzleSolved = false;
      _showSuccessAnimation = false;
      _shuffledPieces.shuffle(_random);
    });
  }

  Widget _buildPuzzlePiece(ui.Image image, int index,
      {bool isDraggable = true}) {
    return FutureBuilder<Uint8List?>(
      future: _imageToBytes(image),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return isDraggable
              ? Draggable<int>(
                  data: index,
                  feedback: Material(
                    color: Colors.transparent,
                    child: Image.memory(
                      snapshot.data!,
                      width: _anotherPieceSize,
                      height: _anotherPieceSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                  childWhenDragging: Container(
                    width: _anotherPieceSize,
                    height: _anotherPieceSize,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        snapshot.data!,
                        width: _anotherPieceSize,
                        height: _anotherPieceSize,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    snapshot.data!,
                    width: _anotherPieceSize,
                    height: _anotherPieceSize,
                    fit: BoxFit.contain,
                  ),
                );
        }
        return Container(
          width: _anotherPieceSize,
          height: _anotherPieceSize,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }

  Widget _buildDropTarget(int index) {
    return DragTarget<int>(
      onWillAccept: (data) => _placedIndexes[index] == null,
      onAccept: (data) {
        setState(() => _placedIndexes[index] = data);
        _checkCompletion();
      },
      builder: (context, candidateData, rejectedData) {
        final pieceIndex = _placedIndexes[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: pieceIndex != null && pieceIndex < _shuffledPieces.length
              ? _buildPuzzlePiece(_shuffledPieces[pieceIndex], pieceIndex,
                  isDraggable: false)
              : Center(
                  child: Text(
                    'Drop here',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                        fontFamily: "comic_neue"),
                  ),
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/drag_puzzle_bg.png",
            height: ScreenUtils().screenHeight(context),
            width: ScreenUtils().screenWidth(context),
            fit: BoxFit.fill,
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.feedContentPadding),
                child: Container(
                  width: ScreenUtils().screenWidth(context),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: AppColors.colorBlack.withOpacity(0.25))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: ScreenUtils().screenHeight(context) * 0.02,
                      ),
                      Text(
                        'Match Letter',
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontFamily: "comic_neue"),
                      ),
                      SizedBox(
                        height: ScreenUtils().screenHeight(context) * 0.01,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: ScreenUtils().screenWidth(context) * 0.4,
                            height: ScreenUtils().screenHeight(context) * 0.15,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFFE8B388),
                                    Color(0xFFF8E98E),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                    color:
                                        AppColors.colorBlack.withOpacity(0.25),
                                  )
                                ]),
                            child: Center(
                              child: Text(
                                selectedLetter,
                                style: TextStyle(
                                    fontSize: 60,
                                    color: AppColors.colorBlack,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Bounceable(
                                onTap: _resetPuzzle,
                                child: Icon(Icons.refresh)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtils().screenHeight(context) * 0.03,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          if (_showHint)
                            Opacity(
                              opacity: _hintOpacity,
                              child: RepaintBoundary(
                                key: _repaintKey,
                                child: Container(
                                  width: _anotherPieceSize * 2,
                                  height: _anotherPieceSize * 2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      selectedLetter,
                                      style: TextStyle(
                                        fontSize: _anotherPieceSize * 1.2,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Container(
                            width: _pieceSize * 2,
                            height: _pieceSize * 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: _pieceCount,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: _buildDropTarget(index),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      if (_isImageLoaded && !_isPuzzleSolved)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.center,
                            children:
                                List.generate(_shuffledPieces.length, (index) {
                              if (_placedIndexes.contains(index)) {
                                return const SizedBox.shrink();
                              }
                              return _buildPuzzlePiece(
                                  _shuffledPieces[index], index);
                            }),
                          ),
                        ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Success animation overlay
          if (_showSuccessAnimation)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/images/animations/earn_money.json',
                    repeat: true,
                    onLoaded: (composition) {},
                  ),
                  AnimatedEarnedCoinsText(),
                  SizedBox(
                    height: ScreenUtils().screenHeight(context) * 0.05,
                  ),
                  CommonButton(
                      onTap: () {
                        if (currentIndex < alphabetList.length - 1) {
                          currentIndex++;
                          setState(() {
                            selectedLetter = alphabetList[currentIndex];
                            _isPuzzleSolved = false;
                          });
                          _generatePuzzle();
                        } else {
                          // All letters completed
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                              const Text('Congratulations! You completed all letters!'),
                              duration: const Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }
                      },
                      height: ScreenUtils().screenHeight(context) * 0.04,
                      width: ScreenUtils().screenWidth(context) * 0.5,
                      buttonColor: AppColors().colorDarkBlue,
                      buttonName: "Next Alphabet",
                      fontSize: 16,
                      borderRadius: 10,
                      buttonTextColor: AppColors.white.withOpacity(0.9),
                      gradientColor1: AppColors().colorDarkBlue,
                      gradientColor2: AppColors.colorSkyBlue300)
                ],
              )),
            ),
        ],
      ),
    );
  }
}
