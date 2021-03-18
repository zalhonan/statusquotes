import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../stores/favorities_store.dart';
import '../widgets/quote_card.dart';
import '../widgets/app_scaffold.dart';
import '../services/constants.dart';
import '../widgets/expandable_app_bar.dart';

class Favorities extends StatelessWidget {
  static const String id = '/favorites';

  @override
  Widget build(BuildContext context) {
    //обращение к стору для текущей категории и цитаты
    final _favStore = Provider.of<FavoritiesStore>(context);

    ScrollController _controller = ScrollController();

    if (_favStore.favQuotesList.length == 0) {
      return AppScaffold(
        currentSelectedNavBarItem: 3,
        noAppBar: true,
        body: Scrollbar(
          child: CustomScrollView(
            controller: _controller,
            slivers: [
              ExpandableAppBar(
                  title: 'favoritesNoItems'.tr(),
                  controller: _controller,
                  index: 0,
                  backgroundImage: AssetImage('images/appbars/buddha2.jpg'),
                  backgroundColor: Colors.brown),
              SliverToBoxAdapter(
                child: QuoteCard(
                  quote: favEmpty(context),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return AppScaffold(
        noAppBar: true,
        currentSelectedNavBarItem: 3,
        body: Scrollbar(
          child: CustomScrollView(
            controller: _controller,
            slivers: [
              ExpandableAppBar(
                  title: 'favorites'.tr(),
                  controller: _controller,
                  index: 0,
                  backgroundImage: AssetImage('images/appbars/buddha2.jpg'),
                  backgroundColor: Colors.brown),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  // управление через index
                  (BuildContext context, int index) {
                    return _favStore.favQuotesList
                        .map((quote) => QuoteCard(quote: quote))
                        .toList()[index];
                    // маппинг по схеме
                    // items.map((item) => ItemWidget(item: item)).toList(),
                  },
                  // кол-во элементов
                  childCount: _favStore.favQuotesList.length,
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
