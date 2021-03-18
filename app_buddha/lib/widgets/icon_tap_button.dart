import 'package:flutter/material.dart';
import '../services/colors.dart';

class IconTapButton extends StatelessWidget {
  IconTapButton({Key key, @required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 40,
      color: kColorDivider,
    );
  }
}
