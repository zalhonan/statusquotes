import 'package:mobx/mobx.dart';
import '../models/models.dart';
import 'package:easy_localization/easy_localization.dart';

part 'quote_store.g.dart';

// запуск на кодогенерацию:
// flutter pub run build_runner build --delete-conflicting-outputs

class _QuoteImpl extends QuoteStore with _$_QuoteImpl {}

abstract class QuoteStore with Store {
  factory QuoteStore.create() => _QuoteImpl();
  QuoteStore();

  @observable
  Author currentAuthor = Author();

  @action
  void setAuthor(Author newAuthor) {
    currentAuthor = newAuthor;
  }

  @observable
  QuoteCategory currentCategory = QuoteCategory(id: 2, name: "happiness");

  @observable
  Quote currentQuote =
      Quote(id: 0, author: 'fixedAuthor'.tr(), content: "Just nothing");

  @action
  void setQuote(Quote newQuote) {
    currentQuote = newQuote;
  }

  @action
  void setCategory(QuoteCategory newCategory) {
    currentCategory = newCategory;
  }
}
