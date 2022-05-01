import 'package:flutter/material.dart';
import 'constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.onPressed,
    this.minWidth = 135.0,
    this.height = 62.0,
    required this.color,
  });

  final VoidCallback onPressed;
  final String text;
  final double minWidth;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minWidth,
      height: height,
      child: RaisedButton(
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(color: myBlack)
        ),
        onPressed: onPressed,
        color: Colors.black,
        textColor: Colors.white,
        child: Text(
          text,
        ),
      ),
    );
  }
}