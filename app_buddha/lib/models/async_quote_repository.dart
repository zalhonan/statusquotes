import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../services/constants.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:easy_localization/easy_localization.dart';

class AsyncQuoteRepository {
  //передаём клиент в конструктор для удобства мокирования
  http.Client client;

  AsyncQuoteRepository({@required this.client});

  // адаптер для перевода ответа сервера в модель Quote
  Quote _responseToQuote(Map<dynamic, dynamic> responseMap) {
    return Quote(
      id: responseMap["id"],
      rating: responseMap["rating"],
      content: responseMap["content"],
      authorId: responseMap["author_id"],
      author: 'fixedAuthor'.tr(), //TODO: автоподстановка имени из API
      languageId: responseMap["language_id"],
      categoryId: responseMap["category1_id"], //для целей хранения не важно
    );
  }

  Future<Quote> getQuoteOfTheDayFromAPI(String language, int author) async {
    // ходит по адресу из константы и возвращает случайную цитату по языку и автору

    String url =
        kQuotesApi + "random_quote/?language=${language}&author=${author}";
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // utf8
      String source = Utf8Decoder().convert(response.bodyBytes);
      Map responseMap = json.decode(source);
      return _responseToQuote(responseMap);
    } else {
      throw Exception('Failed ' + response.statusCode.toString());
    }
  }

  Future<List<QuoteCategory>> getCategoriesFromAPI(
      String language, int author) async {
    // возвращает список категорий из API

    List<QuoteCategory> res = [];
    String url = kQuotesApi + "categories/?description=false&author=${author}";

    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // utf8
      String source = Utf8Decoder().convert(response.bodyBytes);

      var responseListMap = json.decode(source);

      for (var category in responseListMap) {
        if (category["count_${language}"] > 0) {
          res.add(
            QuoteCategory(
              name: category["name_${language}"],
              amount: category["count_${language}"],
              id: category["id"],
              emoji: category["emoji"],
              avatar: category["avatar"],
            ),
          );
        }
      }
      return res;
    } else {
      throw Exception('Failed ' + response.statusCode.toString());
    }
  }

  Future<List<Quote>> getQuotesFromAPI(
      String language, int author, int category, String authorName) async {
    // возвращает цитаты по языку, автору и категории

    List<Quote> res = [];

    String url = kQuotesApi +
        "quotes/?language=${language}&author_id=${author}&category_id=${category}&max_chars=2000";

    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // utf8
      String source = Utf8Decoder().convert(response.bodyBytes);

      var responseListMap = json.decode(source);

      for (var quote in responseListMap) {
        Quote quoteToAdd = _responseToQuote(quote);
        quoteToAdd.author = authorName;
        res.add(quoteToAdd);
      }
      return res;
    } else {
      throw Exception('Failed ' + response.statusCode.toString());
    }
  }

  Future<Author> getAuthorFromAPI(String language, int author_id) async {
    // возвращает автора по ID

    Author res;
    String url =
        kQuotesApi + "author_by_id/?description=false&author_id=${author_id}";

    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // utf8
      String source = Utf8Decoder().convert(response.bodyBytes);

      var author = json.decode(source);

      res = Author(
        id: author["id"],
        emoji: author["emoji"],
        avatar: author["avatar"],
        name: author["name_${language}"],
        quotesof: author["quotesof_${language}"],
      );

      return res;
    } else {
      throw Exception('Failed ' + response.statusCode.toString());
    }
  }

  Future<List<BackgroundPicture>> getBackgroundsFromAPI(String language) async {
    // возвращает список фоновых картинок из API

    List<BackgroundPicture> res = [];
    String url = kQuotesApi + "backgrounds/";

    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // utf8
      String source = Utf8Decoder().convert(response.bodyBytes);

      var responseListMap = json.decode(source);

      for (var background in responseListMap) {
        res.add(
          BackgroundPicture(
              id: background["id"],
              name: background["name_${language}"],
              search: background["search"],
              folder: background["folder"],
              count: background["count"]),
        );
      }
      return res;
    } else {
      throw Exception('Failed ' + response.statusCode.toString());
    }
  }
}
