import 'package:flutter/material.dart';
import '../services/colors.dart';

class ProgressBarIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        child: Center(
          child: Container(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kColorSecondaryText),
              strokeWidth: 5,
            ),
          ),
        ),
      ),
    );
  }
}
