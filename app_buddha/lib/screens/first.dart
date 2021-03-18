import 'package:buddha_quotes/stores/background_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

import '../stores/quote_store.dart';
import '../models/models.dart';
import '../screens/quotes_list.dart';
import '../widgets/quote_card.dart';
import '../widgets/category_card.dart';
import '../widgets/progress_bar_indicator.dart';
import '../widgets/app_scaffold.dart';
import '../services/constants.dart';
import '../models/async_quote_repository.dart';
import '../widgets/expandable_app_bar.dart';

class First extends StatefulWidget {
  static const String id = '/';

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  final _repository = AsyncQuoteRepository(client: http.Client());

  @override
  Widget build(BuildContext context) {
    //обращение к стору для текущей категории и цитаты
    final quoteStore = Provider.of<QuoteStore>(context);

    //обращение к втору для бекграундов
    final backgroundStore = Provider.of<BackgroundStore>(context);

    final Future<Quote> quoteOfTheDay =
        _repository.getQuoteOfTheDayFromAPI(kLang, kFixedAuthorId);
    final Future<List<QuoteCategory>> quoteCategories =
        _repository.getCategoriesFromAPI(kLang, kFixedAuthorId);
    final Future<Author> quoteAuthor =
        _repository.getAuthorFromAPI(kLang, kFixedAuthorId);
    final Future<List<BackgroundPicture>> quoteBackgrounds =
        _repository.getBackgroundsFromAPI(kLang);

    ScrollController _controller = ScrollController();

    return AppScaffold(
      currentSelectedNavBarItem: 0,
      noAppBar: true,
      body: FutureBuilder(
        // ждем несколько future одновременно
        future: Future.wait(
            [quoteOfTheDay, quoteCategories, quoteAuthor, quoteBackgrounds]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          // проверяем, есть ли все данные
          if (snapshot.hasData) {
            // установка данных автора
            quoteStore.setAuthor(snapshot.data[2]);

            // заполним цитатой дня репозиторий
            quoteStore.setQuote(snapshot.data[0]);

            // заполним бекграунды
            backgroundStore.setBackgrounds(snapshot.data[3]);

            // установка цитаты дня
            Quote quoteOfTheDay = snapshot.data[0];
            quoteOfTheDay.author = snapshot.data[2].name;

            return Scrollbar(
              child: CustomScrollView(
                controller: _controller,
                slivers: [
                  ExpandableAppBar(
                      title: 'fixedTitle'.tr(),
                      controller: _controller,
                      index: 0,
                      backgroundImage: AssetImage('images/appbars/buddha1.jpg'),
                      backgroundColor: Colors.blueGrey),
                  SliverToBoxAdapter(
                    child: QuoteCard(
                      quote: quoteOfTheDay,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      // управление через index
                      (BuildContext context, int index) {
                        // маппинг по схеме
                        // items.map((item) => ItemWidget(item: item)).toList(),
                        return snapshot.data[1]
                            .map(
                              (category) => CategoryCard(
                                category: category,
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    QuotesList.id,
                                  );
                                },
                              ),
                            )
                            .toList()[index];
                      },
                      // кол-во элементов
                      childCount: snapshot.data[1].length,
                    ),
                  )
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('errorText'.tr() + '\n ${snapshot.error}'),
            );
          }
          return ProgressBarIndicator();
        },
      ),
    );
  }
}
