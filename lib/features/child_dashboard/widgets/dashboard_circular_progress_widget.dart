import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class DashboardCircularProgressWidget extends StatefulWidget {
  const DashboardCircularProgressWidget({super.key});

  @override
  State<DashboardCircularProgressWidget> createState() => _DashboardCircularProgressWidgetState();
}

class _DashboardCircularProgressWidgetState extends State<DashboardCircularProgressWidget> {
  double progress = 0.6;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Circular Progress Indicator
        SizedBox(
          height: ScreenUtils().screenHeight(context)*0.03,
          width: ScreenUtils().screenHeight(context)*0.03,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 2, // Width of the progress indicator line
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Fill color
            backgroundColor: Colors.grey[300], // Background color
          ),
        ),
        // Text displaying the completion percentage
        Text(
          '${(progress * 100).toInt()}%',
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
