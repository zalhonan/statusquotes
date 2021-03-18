import 'package:flutter/material.dart';
import 'dart:convert';

class Quote {
  Quote({
    this.id,
    this.categoryId,
    this.rating,
    this.authorId,
    this.author,
    this.languageId,
    this.content,
  });

  final int id;
  final int categoryId;
  final int rating;
  final int authorId;
  String author;
  final int languageId;
  final String content;

  factory Quote.fromJson(Map<String, dynamic> jsonData) {
    return Quote(
      id: jsonData["id"],
      categoryId: jsonData["categoryId"],
      rating: jsonData["rating"],
      authorId: jsonData["authorId"],
      author: jsonData["author"],
      languageId: jsonData["languageId"],
      content: jsonData["content"],
    );
  }

  static Map<String, dynamic> toMap(Quote quote) => {
        'id': quote.id,
        'categoryId': quote.categoryId,
        'rating': quote.rating,
        'authorId': quote.authorId,
        'author': quote.author,
        'languageId': quote.languageId,
        'content': quote.content,
      };

  static String encode(List<Quote> quotes) => json.encode(
        quotes
            .map<Map<String, dynamic>>((quote) => Quote.toMap(quote))
            .toList(),
      );

  static List<Quote> decode(String quote) =>
      (json.decode(quote) as List<dynamic>)
          .map<Quote>((item) => Quote.fromJson(item))
          .toList();
}

class QuoteCategory {
  QuoteCategory({this.id, this.name, this.emoji, this.avatar, this.amount});

  final int id;
  final String emoji;
  final String avatar;
  final String name;
  final int amount;
}

class Author {
  Author({this.id, this.name, this.avatar, this.emoji, this.quotesof});

  final int id;
  final String emoji;
  final String avatar;
  final String name;
  final String quotesof;
}

class QuoteFontSize {
  QuoteFontSize({this.name, this.quoteSize, this.authorSize});

  final String name;
  final int quoteSize;
  final int authorSize;
}

class TextShadow {
  TextShadow({this.name, this.quoteShadow, this.textColor});

  final String name;
  final List<Shadow> quoteShadow;
  final Color textColor;
}

class BackgroundPicture {
  BackgroundPicture({this.id, this.name, this.search, this.folder, this.count});

  final int id;
  final String name;
  final String search;
  final String folder;
  final int count;
}
