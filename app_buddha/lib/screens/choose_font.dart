//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../models/models.dart';
import '../services/decorations.dart';
import '../stores/decoration_store.dart';
import '../services/constants.dart';
import '../widgets/expandable_app_bar.dart';

void chooseFont(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      // стор, в котором хранятся элементы оформления
      final _decorationStore = Provider.of<DecorationStore>(context);

      // контроллер для перехода по списку
      ScrollController _controller = ScrollController();

      double _screenWidth = MediaQuery.of(context).size.width;

      // текущий размер аппдара
      double _appBarHeight = AppBar().preferredSize.height;

      double _index0 = 0;
      double _index1 =
          ((quoteShadows.length / 3) * _screenWidth / 3).toDouble() +
              kExpandedAppBarHeight -
              _appBarHeight;
      double _index2 =
          (_index1 + (quoteFontSizes.length / 3) * _screenWidth / 3)
                  .toDouble() +
              kExpandedAppBarHeight -
              _appBarHeight;

      return Container(
        height: MediaQuery.of(context).size.height / 4 * 3,
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            ExpandableAppBar(
              controller: _controller,
              index: _index0,
              title: "fontShadows".tr(),
              backgroundColor: Colors.yellow[900],
              backgroundImage: AssetImage('images/appbars/shadow.jpg'),
              expandedHeight: 56,
            ),
            SliverGrid.count(
              crossAxisCount: 3,
              children: [
                for (TextShadow currentShadow in quoteShadows)
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              currentShadow.name,
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 35,
                                color: currentShadow.textColor,
                                shadows: currentShadow.quoteShadow,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      _decorationStore
                          .setQuoteShadow(currentShadow.quoteShadow);
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
            ExpandableAppBar(
              controller: _controller,
              index: _index1,
              title: "fontSizes".tr(),
              backgroundColor: Colors.blueGrey,
              backgroundImage: AssetImage('images/appbars/size.jpg'),
              expandedHeight: 56,
            ),
            SliverGrid.count(
              crossAxisCount: 3,
              children: [
                for (QuoteFontSize currentFontSize in quoteFontSizes)
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              currentFontSize.name,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: currentFontSize.quoteSize.toDouble(),
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      _decorationStore.setQuoteFontSize(currentFontSize);
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
            ExpandableAppBar(
              controller: _controller,
              index: _index2,
              title: "fonts".tr(),
              backgroundColor: Colors.brown,
              backgroundImage: AssetImage('images/appbars/font.jpg'),
              expandedHeight: 56,
            ),
            SliverGrid.count(
              crossAxisCount: 3,
              children: [
                for (String currentFont in quoteFonts)
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              currentFont
                                  .split(new RegExp(r"(?<=[a-z])(?=[A-Z])"))
                                  .join("\n"),
                              style: TextStyle(
                                fontFamily: currentFont,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      _decorationStore.setQuoteFont(currentFont);
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
