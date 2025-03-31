
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../helper/screen_utils.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.suffixIcon,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenUtils().screenWidth(context) * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscure : false,
        keyboardType: TextInputType.emailAddress,
        cursorColor: AppColors.colorPrimaryText,
        cursorWidth: 2,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.colorBlack,
          fontFamily: "Poppins",
          fontSize: 18,
        ),
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: AppColors.colorPrimaryText),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          )
              : (widget.suffixIcon != null ? Icon(widget.suffixIcon, color: AppColors.colorPrimaryText) : null),
          prefixIcon: Icon(widget.prefixIcon, color: AppColors.colorPrimaryText),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.colorPrimaryText,
            fontFamily: "Poppins",
            fontSize: 16
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtils().screenWidth(context) * 0.03),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.white,
        ),
      ),
    );
  }
}
