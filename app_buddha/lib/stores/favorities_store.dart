import 'package:mobx/mobx.dart';
import '../models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorities_store.g.dart';

// запуск на кодогенерацию:
// flutter pub run build_runner build --delete-conflicting-outputs

class _FavoritiesImpl extends FavoritiesStore with _$_FavoritiesImpl {}

abstract class FavoritiesStore with Store {
  factory FavoritiesStore.create() => _FavoritiesImpl();
  FavoritiesStore() {
    _getFromStorage();
  }

  //забирает из хранилища список
  _getFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favQuotes = prefs.getString('myFavQuotes') ?? "";
    if (favQuotes != "") {
      favIdsList = ObservableList();
      favQuotesList = ObservableList();

      List<Quote> savedQuoteList = Quote.decode(favQuotes);
      for (Quote quote in savedQuoteList) {
        favIdsList.add(quote.id);
        favQuotesList.add(quote);
      }
    }
  }

  //переводит фаворитис в строку и сохраняет
  _saveToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("myFavQuotes", Quote.encode(favQuotesList));
  }

  // обычный List не уведомляет MobX об измнениях, используем ObservableList
  ObservableList<int> favIdsList = ObservableList();

  ObservableList<Quote> favQuotesList = ObservableList();

  @action
  void switchFavs(Quote quote) {
    if (!favIdsList.contains(quote.id)) {
      favIdsList.add(quote.id);
      favQuotesList.add(quote);
    } else {
      favIdsList.removeWhere((element) => element == quote.id);
      favQuotesList.removeWhere((element) => element.id == quote.id);
    }
    _saveToStorage();
  }
}
