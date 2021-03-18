import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:easy_localization/easy_localization.dart';

import '../models/models.dart';
import '../stores/decoration_store.dart';
import '../widgets/sharing_button.dart';
import '../widgets/app_scaffold.dart';
import '../services/get_square_sizes.dart';
import '../services/constants.dart';
import '../screens/choose_back.dart';
import '../screens/choose_font.dart';
import '../stores/quote_store.dart';

class ShareQuote extends StatefulWidget {
  static const String id = '/share';

  @override
  _ShareQuoteState createState() => _ShareQuoteState();
}

class _ShareQuoteState extends State<ShareQuote> {
  double _currentWidth;
  double _currentHeight;
  bool _square = false;

  // спиннер на кнопке - true
  bool _button1;
  // ключ для поиска виджета
  final GlobalKey _globalKey = GlobalKey(debugLabel: 'debug');

  @override
  void initState() {
    _button1 = false;
    super.initState();
  }

  // Собственно функция для снятия скриншота с виджета, обернутого в RepaintBoundary
  Future<Null> shareScreenshot() async {
    // включить спиннер
    setState(() {
      _button1 = true;
    });
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      // if (boundary.debugNeedsPaint) {
      //   Timer(Duration(seconds: 1), () => shareScreenshot());
      //   return null;
      // }
      ui.Image image = await boundary.toImage(pixelRatio: 5);
      // final directory = (await getExternalStorageDirectory()).path;
      // final directory = (await getApplicationDocumentsDirectory()).path;
      final directory = (await getTemporaryDirectory()).path;
      ByteData byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final File imgFile = File('$directory/quote.png');
      imgFile.writeAsBytesSync(pngBytes);
      final RenderBox box = context.findRenderObject();
      Share.shareFiles(['$directory/quote.png'],
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } on PlatformException catch (e) {
      print("Exception while taking screenshot:" + e.toString());
    }
    setState(() {
      _button1 = false;
    });
  }

  void changeAspect(BuildContext context) {
    // максимальная ширина - ширина экрана
    // максимальная высота - высота экрана-195 (kSafeZone)
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (_square) {
      setState(
        () {
          _square = false;
          _currentWidth = screenWidth;
          if (_currentWidth > screenHeight - kSafeZone) {
            _currentHeight = screenHeight - kSafeZone;
            _currentWidth = _currentHeight;
          } else {
            _currentHeight = _currentWidth;
          }
        },
      );
    } else {
      setState(
        () {
          _square = true;
          _currentHeight = screenHeight - kSafeZone;
          _currentWidth = _currentHeight / 16 * 9;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //обращение к стору для текущей категории и цитаты
    final _quoteStore = Provider.of<QuoteStore>(context);
    //обращение к стору для декорирования цитаты
    final _decorationStore = Provider.of<DecorationStore>(context);

    Quote _currentQuote = _quoteStore.currentQuote;

    return AppScaffold(
      title: "shareTitle".tr(),
      currentSelectedNavBarItem: 2,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Умещает цитату на экран
          Card(
            elevation: 3,
            child: RepaintBoundary(
              key: _globalKey,
              child: Observer(
                builder: (_) => Container(
                  height: _currentHeight == null
                      ? getSquareSizes(context)
                      : _currentHeight,
                  width: _currentWidth == null
                      ? getSquareSizes(context)
                      : _currentWidth,
                  decoration: _decorationStore.quoteBackgroundDecoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        height: _currentHeight == null
                            ? getSquareSizes(context) - 140
                            : _currentHeight - 140,
                        child: Center(
                          child: AutoSizeText(
                            '\"${_currentQuote.content}\"',
                            style: TextStyle(
                              fontSize: _decorationStore.quoteFontSize.quoteSize
                                  .toDouble(),
                              color: _decorationStore.quoteTextColor,
                              fontFamily: _decorationStore.quoteFont,
                              shadows: _decorationStore.quoteTextShadow,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        child: AutoSizeText(
                          _currentQuote.author,
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: _decorationStore.quoteFontSize.authorSize
                                .toDouble(),
                            color: _decorationStore.quoteTextColor,
                            fontFamily: _decorationStore.quoteFont,
                            shadows: _decorationStore.quoteTextShadow,
                          ),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SharingButton(
                tapIcon: FontAwesomeIcons.font,
                title: 'font'.tr(),
                tapFunction: chooseFont,
              ),
              SharingButton(
                tapIcon: Icons.color_lens,
                title: 'back'.tr(),
                tapFunction: chooseBack,
              ),
              SharingButton(
                tapIcon: Icons.aspect_ratio,
                title: 'aspect'.tr(),
                tapFunction: changeAspect,
              ),
              // TODO: возможно переделать передачу иконнки на виджет
              SharingButton(
                tapIcon: _button1 ? Icons.hourglass_top_sharp : Icons.send,
                title: 'share'.tr(),
                tapFunction: (context) {
                  shareScreenshot();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
