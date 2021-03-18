// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$_QuoteImpl on QuoteStore, Store {
  final _$currentAuthorAtom = Atom(name: 'QuoteStore.currentAuthor');

  @override
  Author get currentAuthor {
    _$currentAuthorAtom.reportRead();
    return super.currentAuthor;
  }

  @override
  set currentAuthor(Author value) {
    _$currentAuthorAtom.reportWrite(value, super.currentAuthor, () {
      super.currentAuthor = value;
    });
  }

  final _$currentCategoryAtom = Atom(name: 'QuoteStore.currentCategory');

  @override
  QuoteCategory get currentCategory {
    _$currentCategoryAtom.reportRead();
    return super.currentCategory;
  }

  @override
  set currentCategory(QuoteCategory value) {
    _$currentCategoryAtom.reportWrite(value, super.currentCategory, () {
      super.currentCategory = value;
    });
  }

  final _$currentQuoteAtom = Atom(name: 'QuoteStore.currentQuote');

  @override
  Quote get currentQuote {
    _$currentQuoteAtom.reportRead();
    return super.currentQuote;
  }

  @override
  set currentQuote(Quote value) {
    _$currentQuoteAtom.reportWrite(value, super.currentQuote, () {
      super.currentQuote = value;
    });
  }

  final _$QuoteStoreActionController = ActionController(name: 'QuoteStore');

  @override
  void setAuthor(Author newAuthor) {
    final _$actionInfo =
        _$QuoteStoreActionController.startAction(name: 'QuoteStore.setAuthor');
    try {
      return super.setAuthor(newAuthor);
    } finally {
      _$QuoteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuote(Quote newQuote) {
    final _$actionInfo =
        _$QuoteStoreActionController.startAction(name: 'QuoteStore.setQuote');
    try {
      return super.setQuote(newQuote);
    } finally {
      _$QuoteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(QuoteCategory newCategory) {
    final _$actionInfo = _$QuoteStoreActionController.startAction(
        name: 'QuoteStore.setCategory');
    try {
      return super.setCategory(newCategory);
    } finally {
      _$QuoteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentAuthor: ${currentAuthor},
currentCategory: ${currentCategory},
currentQuote: ${currentQuote}
    ''';
  }
}
