// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$_DecorationImpl on DecorationStore, Store {
  final _$quoteBackgroundDecorationAtom =
      Atom(name: 'DecorationStore.quoteBackgroundDecoration');

  @override
  BoxDecoration get quoteBackgroundDecoration {
    _$quoteBackgroundDecorationAtom.reportRead();
    return super.quoteBackgroundDecoration;
  }

  @override
  set quoteBackgroundDecoration(BoxDecoration value) {
    _$quoteBackgroundDecorationAtom
        .reportWrite(value, super.quoteBackgroundDecoration, () {
      super.quoteBackgroundDecoration = value;
    });
  }

  final _$quoteFontSizeAtom = Atom(name: 'DecorationStore.quoteFontSize');

  @override
  QuoteFontSize get quoteFontSize {
    _$quoteFontSizeAtom.reportRead();
    return super.quoteFontSize;
  }

  @override
  set quoteFontSize(QuoteFontSize value) {
    _$quoteFontSizeAtom.reportWrite(value, super.quoteFontSize, () {
      super.quoteFontSize = value;
    });
  }

  final _$quoteTextColorAtom = Atom(name: 'DecorationStore.quoteTextColor');

  @override
  Color get quoteTextColor {
    _$quoteTextColorAtom.reportRead();
    return super.quoteTextColor;
  }

  @override
  set quoteTextColor(Color value) {
    _$quoteTextColorAtom.reportWrite(value, super.quoteTextColor, () {
      super.quoteTextColor = value;
    });
  }

  final _$quoteFontAtom = Atom(name: 'DecorationStore.quoteFont');

  @override
  String get quoteFont {
    _$quoteFontAtom.reportRead();
    return super.quoteFont;
  }

  @override
  set quoteFont(String value) {
    _$quoteFontAtom.reportWrite(value, super.quoteFont, () {
      super.quoteFont = value;
    });
  }

  final _$quoteTextShadowAtom = Atom(name: 'DecorationStore.quoteTextShadow');

  @override
  List<Shadow> get quoteTextShadow {
    _$quoteTextShadowAtom.reportRead();
    return super.quoteTextShadow;
  }

  @override
  set quoteTextShadow(List<Shadow> value) {
    _$quoteTextShadowAtom.reportWrite(value, super.quoteTextShadow, () {
      super.quoteTextShadow = value;
    });
  }

  final _$DecorationStoreActionController =
      ActionController(name: 'DecorationStore');

  @override
  dynamic setQuoteBackgroundImage(String newImagePath) {
    final _$actionInfo = _$DecorationStoreActionController.startAction(
        name: 'DecorationStore.setQuoteBackgroundImage');
    try {
      return super.setQuoteBackgroundImage(newImagePath);
    } finally {
      _$DecorationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setQuoteBackgroundImageNetwork(String newImagePath) {
    final _$actionInfo = _$DecorationStoreActionController.startAction(
        name: 'DecorationStore.setQuoteBackgroundImageNetwork');
    try {
      return super.setQuoteBackgroundImageNetwork(newImagePath);
    } finally {
      _$DecorationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setQuoteBackgroundGradient(BoxDecoration currentGradient) {
    final _$actionInfo = _$DecorationStoreActionController.startAction(
        name: 'DecorationStore.setQuoteBackgroundGradient');
    try {
      return super.setQuoteBackgroundGradient(currentGradient);
    } finally {
      _$DecorationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuoteBackgroundColor(Color newColor) {
    final _$actionInfo = _$DecorationStoreActionController.startAction(
        name: 'DecorationStore.setQuoteBackgroundColor');
    try {
      return super.setQuoteBackgroundColor(newColor);
    } finally {
      _$DecorationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuoteShadow(List<Shadow> newShadows) {
    final _$actionInfo = _$DecorationStoreActionController.startAction(
        name: 'DecorationStore.setQuoteShadow');
    try {
      return super.setQuoteShadow(newShadows);
    } finally {
      _$DecorationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuoteFont(String newFont) {
    final _$actionInfo = _$DecorationStoreActionController.startAction(
        name: 'DecorationStore.setQuoteFont');
    try {
      return super.setQuoteFont(newFont);
    } finally {
      _$DecorationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuoteFontSize(QuoteFontSize newFontSize) {
    final _$actionInfo = _$DecorationStoreActionController.startAction(
        name: 'DecorationStore.setQuoteFontSize');
    try {
      return super.setQuoteFontSize(newFontSize);
    } finally {
      _$DecorationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quoteBackgroundDecoration: ${quoteBackgroundDecoration},
quoteFontSize: ${quoteFontSize},
quoteTextColor: ${quoteTextColor},
quoteFont: ${quoteFont},
quoteTextShadow: ${quoteTextShadow}
    ''';
  }
}
