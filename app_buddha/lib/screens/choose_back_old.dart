import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../services/decorations.dart';
import '../stores/decoration_store.dart';
import '../stores/background_store.dart';
import '../services/constants.dart';
import '../services/colors.dart';
import '../widgets/expandable_app_bar.dart';
import '../models/models.dart';

void chooseBack(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      // стор для хранения бекграундов
      final backgroundStore = Provider.of<BackgroundStore>(context);

      // стор для установки декорирования
      final decorationStore = Provider.of<DecorationStore>(context);

      // контроллер для перехода по списку
      ScrollController _controller = ScrollController();

      double _screenWidth = MediaQuery.of(context).size.width;

      // текущий размер аппбара
      double _appBarHeight = AppBar().preferredSize.height;

      //
      List<BackgroundPicture> currentBacks = backgroundStore.backgroundsList;
      var backsMap = currentBacks.asMap();
      // currentBacksMap.forEach((k, v) => print('${k}: ${v.id}'));

      double _index0 = 0;
      double _index1 =
          ((quoteBackgroundPictures.length / 3) * _screenWidth / 3).toDouble() +
              kExpandedAppBarHeight -
              _appBarHeight;
      double _index2 =
          (_index1 + (gradientList.length / 3) * _screenWidth / 3).toDouble() +
              kExpandedAppBarHeight -
              _appBarHeight;

      return Container(
        height: MediaQuery.of(context).size.height / 4 * 3,
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            for (BackgroundPicture currentBackground
                in backgroundStore.backgroundsList) ...[
              ExpandableAppBar(
                controller: _controller,
                index: _index0,
                title: currentBackground.name,
                backgroundColor: kColorDarkPrimary,
                backgroundImage: CachedNetworkImageProvider(
                  kQuotesApi + "images/" + currentBackground.folder + "/4.jpg",
                ),
              ),
              SliverGrid.count(
                crossAxisCount: 3,
                children: [
                  for (int currentImageNumber in [
                    for (var i = 1; i < currentBackground.count + 1; i += 1) i
                  ])
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              kQuotesApi +
                                  "images/" +
                                  currentBackground.folder +
                                  "/previews/" +
                                  currentImageNumber.toString() +
                                  ".jpg",

                              //images/buddha/previews/1.jpg
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        String newBack = kQuotesApi +
                            "images/" +
                            currentBackground.folder +
                            "/" +
                            currentImageNumber.toString() +
                            ".jpg";
                        decorationStore.setQuoteBackgroundImageNetwork(newBack);
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ]
          ],
        ),
      );
    },
  );
}
