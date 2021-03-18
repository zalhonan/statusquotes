import 'package:flutter/material.dart';
import './constants.dart';

double getSquareSizes(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  if (screenWidth > screenHeight - kSafeZone) {
    return screenHeight - kSafeZone;
  } else {
    return screenWidth;
  }
}
