import 'package:flutter/material.dart';
import '../services/colors.dart';

class SharingButton extends StatelessWidget {
  SharingButton({this.tapIcon, this.title, this.tapFunction});

  final double _height = 100;
  final double _width = 60;

  IconData tapIcon;
  String title;
  Function tapFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      color: Colors.white24,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 5,
            ),
            InkWell(
              child: tapIcon != Icons.hourglass_top_sharp
                  ? Icon(
                      tapIcon,
                      size: 48,
                      color: kColorSecondaryText,
                    )
                  : Center(
                      child: Container(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              kColorSecondaryText),
                          strokeWidth: 5,
                        ),
                        height: 40,
                        width: 40,
                      ),
                    ),
              onTap: () {
                tapFunction(context);
              },
            ),
            Container(
              height: 5,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
