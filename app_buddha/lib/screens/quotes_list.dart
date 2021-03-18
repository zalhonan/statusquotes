import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

import '../services/constants.dart';
import '../models/async_quote_repository.dart';
import '../widgets/quote_card.dart';
import '../widgets/progress_bar_indicator.dart';
import '../widgets/app_scaffold.dart';
import '../stores/quote_store.dart';
import '../widgets/expandable_app_bar.dart';
import '../services/category_inspired.dart';

class QuotesList extends StatefulWidget {
  static const String id = '/quotes';

  @override
  _QuotesListState createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> {
  @override
  Widget build(BuildContext context) {
    //обращение к стору для текущей категории и цитаты
    final _quoteStore = Provider.of<QuoteStore>(context);

    // клиент для запроса страниц
    final _repository = AsyncQuoteRepository(client: http.Client());

    final ScrollController _controller = ScrollController();

    return AppScaffold(
      currentSelectedNavBarItem: 1,
      noAppBar: true,
      body: FutureBuilder(
        future: _repository.getQuotesFromAPI(kLang, kFixedAuthorId,
            _quoteStore.currentCategory.id, _quoteStore.currentAuthor.name),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scrollbar(
              child: CustomScrollView(
                controller: _controller,
                slivers: [
                  ExpandableAppBar(
                      title: categoryInspired(_quoteStore.currentCategory.name),
                      controller: _controller,
                      index: 0,
                      backgroundImage: AssetImage('images/appbars/temple.jpg'),
                      backgroundColor: Colors.blueGrey),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      // управление через index
                      (BuildContext context, int index) {
                        // маппинг по схеме
                        // items.map((item) => ItemWidget(item: item)).toList(),
                        return snapshot.data
                            .map((quote) => QuoteCard(quote: quote))
                            .toList()[index];
                      },
                      // кол-во элементов
                      childCount: snapshot.data.length,
                    ),
                  )
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong: \n ${snapshot.error}'),
            );
          }
          return ProgressBarIndicator();
        },
      ),
    );
  }
}
