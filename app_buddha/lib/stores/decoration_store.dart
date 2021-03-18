import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/decorations.dart';
import 'package:cached_network_image/cached_network_image.dart';

part 'decoration_store.g.dart';

// запуск на кодогенерацию:
// flutter pub run build_runner build --delete-conflicting-outputs

class _DecorationImpl extends DecorationStore with _$_DecorationImpl {}

abstract class DecorationStore with Store {
  factory DecorationStore.create() => _DecorationImpl();
  DecorationStore();

  @observable
  BoxDecoration quoteBackgroundDecoration = BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage('images/5.jpg'),
    ),
  ); //

  @action
  setQuoteBackgroundImage(String newImagePath) {
    quoteBackgroundDecoration = BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(newImagePath),
      ),
    ); // textColor = Colors.white;
  }

  @action
  setQuoteBackgroundImageNetwork(String newImagePath) {
    quoteBackgroundDecoration = BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: CachedNetworkImageProvider(newImagePath),
      ),
    ); // textColor = Colors.white;
  }

  @action
  setQuoteBackgroundGradient(BoxDecoration currentGradient) {
    quoteBackgroundDecoration = currentGradient;
  }

  @action
  void setQuoteBackgroundColor(Color newColor) {
    quoteBackgroundDecoration = BoxDecoration(
      color: newColor,
    );
  }

  @observable
  QuoteFontSize quoteFontSize = quoteFontSizes[1];

  //пока не меняем, белый смотрится стильно
  @observable
  Color quoteTextColor = Colors.white;

  @observable
  String quoteFont = quoteFonts[1];

  @observable
  List<Shadow> quoteTextShadow = quoteShadows[1].quoteShadow;

  @action
  void setQuoteShadow(List<Shadow> newShadows) {
    quoteTextShadow = newShadows;
  }

  @action
  void setQuoteFont(String newFont) {
    quoteFont = newFont;
  }

  @action
  void setQuoteFontSize(QuoteFontSize newFontSize) {
    quoteFontSize = newFontSize;
  }
}
