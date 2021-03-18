import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/models.dart';

List<TextShadow> quoteShadows = [
  TextShadow(
      textColor: Colors.black, name: 'noShadows'.tr(), quoteShadow: null),
  TextShadow(textColor: Colors.white, name: 'lightShadow'.tr(), quoteShadow: [
    Shadow(
      color: Colors.black,
      blurRadius: 3,
      offset: Offset(1, 1),
    )
  ]),
  TextShadow(textColor: Colors.white, name: 'flatShadow'.tr(), quoteShadow: [
    Shadow(
      color: Colors.black,
      blurRadius: 1,
      offset: Offset(1, 1),
    )
  ]),
];

List<String> quoteFonts = [
  "Pacifico",
  "Oswald",
  "KellySlab",
  "Pattaya",
  "RuslanDisplay",
  "Roboto",
];

List<QuoteFontSize> quoteFontSizes = [
  QuoteFontSize(name: 'large'.tr(), quoteSize: 45, authorSize: 35),
  QuoteFontSize(name: 'medium'.tr(), quoteSize: 34, authorSize: 24),
  QuoteFontSize(name: 'small'.tr(), quoteSize: 25, authorSize: 15),
];

List<Color> quoteColors = [
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.black26,
  Colors.orange,
  Colors.blue,
  Colors.blueGrey,
  Colors.pink,
  Colors.deepPurple,
  Colors.limeAccent,
  Colors.brown,
  Colors.white,
];

BoxDecoration gradient1 = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.1, 0.4, 0.6, 0.9],
    colors: [Colors.yellow, Colors.red, Colors.indigo, Colors.teal],
  ),
);

BoxDecoration gradient2 = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomLeft,
    stops: [0.1, 0.4, 0.6, 0.9],
    colors: [Colors.blue, Colors.blueAccent, Colors.lightBlue, Colors.teal],
  ),
);

BoxDecoration gradient3 = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.1, 0.4, 0.6, 0.9],
    colors: [Colors.red, Colors.deepOrange, Colors.orangeAccent, Colors.orange],
  ),
);

List<BoxDecoration> gradientList = [
  gradient1,
  gradient2,
  gradient3,
];

List<String> quoteBackgroundPictures = [
  for (var i = 1; i < 10; i += 1) 'images/${i}.jpg'
];
