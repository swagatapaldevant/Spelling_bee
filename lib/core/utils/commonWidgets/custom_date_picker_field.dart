import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class CustomDatePickerField extends StatefulWidget {
  final String? selectedDate;
  final String placeholderText;
  final ValueChanged<String> onDateChanged;

  const CustomDatePickerField({
    super.key,
    required this.onDateChanged,
    required this.placeholderText,
    this.selectedDate,
  });

  @override
  _CustomDatePickerFieldState createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
      text: widget.selectedDate != null ? DateFormat('yyyy').format(DateTime.tryParse(widget.selectedDate!) ?? DateTime.now()) : '',
    );
  }

  @override
  void didUpdateWidget(covariant CustomDatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _dateController.text = widget.selectedDate != null ? DateFormat('yyyy').format(DateTime.tryParse(widget.selectedDate!) ?? DateTime.now()) : '';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.tryParse(widget.selectedDate ?? '') ?? DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedYear = DateFormat('yyyy').format(pickedDate);
      _dateController.text = formattedYear;

      // Pass the full date in ISO string if needed, or only year depending on your use case
      widget.onDateChanged(formattedYear);
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils().screenWidth(context),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtils().screenWidth(context) * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenUtils().screenWidth(context) * 0.02),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _dateController,
        readOnly: true,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: AppColors.colorBlack,
          fontFamily: "comic_neue",
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          hintText: widget.placeholderText,
          hintStyle: TextStyle(
            color: AppColors.colorPrimaryText,
            fontFamily: "comic_neue",
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          border: InputBorder.none,
          prefixIcon: GestureDetector(
            onTap: () => _selectDate(context),
            child: Icon(Icons.calendar_today, color: AppColors.colorPrimaryText),
          ),
        ),
        onTap: () => _selectDate(context),
      ),
    );
  }
}
