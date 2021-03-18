import 'package:flutter/cupertino.dart';
import '../models/models.dart';
import 'package:easy_localization/easy_localization.dart';

// безопасная высота окошка
const int kSafeZone = 236;

// какие фона можно показывать для данного приложения
const List<int> kAllowedbackgrounds = [1, 2, 3, 4];

// API
// const String kQuotesApi = "https://statusquoteseu.herokuapp.com/";
const String kQuotesApi = "https://statusquoteseu2.herokuapp.com/";

// аппбар в выборе фонов и беков в раскрытом виде
const double kExpandedAppBarHeight = 200;

//билд
const String kLang = 'ru'; //язык билда

//цитаты Будды
const int kFixedAuthorId = 1;

//сообщение о пустом избранном
Quote favEmpty(BuildContext context) {
  if (kLang == "ru") {
    return Quote(
      content: "Пока что вы не добавили цитаты в избранное. "
          "Пожалуйста вернитесь на предыдушую страницу и добавьте "
          "в избранное понравившиеся цитаты. Ваш список избранных"
          " цитат будет сохранен на вашем устройстве ",
      author: "С любовью, разработчики",
      id: 0,
    );
  } else {
    return Quote(
      content: "You did not add any quotes to favorites. "
          "Please return to previous pages and do it. "
          "Your favorite quotes will be saved on your device",
      author: "Your fellow developers",
      id: 0,
    );
  }
}
