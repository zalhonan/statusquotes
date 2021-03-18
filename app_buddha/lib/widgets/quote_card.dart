import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

import '../stores/favorities_store.dart';
import '../screens/share_quote.dart';
import '../stores/quote_store.dart';
import '../models/models.dart';
import '../widgets/icon_tap_button.dart';

class QuoteCard extends StatelessWidget {
  QuoteCard({@required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    //обращение к стору для текущей категории и цитаты
    final _quoteStore = Provider.of<QuoteStore>(context);

    //обращение к стору для избранного
    final _favStore = Provider.of<FavoritiesStore>(context);

    final double _spaceBetweenButtons = 7;

    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GestureDetector(
        child: Card(
          elevation: 10,
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: AutoSizeText(
                    '\"${quote.content}\"',
                    maxLines: 7,
                    minFontSize: 6,
                    maxFontSize: 28,
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Text(
                    quote.author,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                // блок кнопок
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Row(
                    children: [
                      InkWell(
                        child: IconTapButton(
                          icon: Icons.content_copy,
                        ),
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text: "${quote.content}\n${quote.author}"));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Container(
//                              alignment: Alignment(0, 1),
                                child: Text('copiedToClipboard'.tr()),
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        width: _spaceBetweenButtons,
                      ),
                      InkWell(
                        child: IconTapButton(
                          icon: Icons.share,
                        ),
                        onTap: () {
                          _quoteStore.setQuote(quote);
                          Navigator.pushNamed(context, ShareQuote.id);
                        },
                      ),
                      Container(
                        width: _spaceBetweenButtons,
                      ),
                      Observer(
                        builder: (_) => InkWell(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                child: child,
                                scale: animation,
                              );
                            },
                            child: _favStore.favIdsList.contains(quote.id)
                                ? IconTapButton(
                                    icon: Icons.favorite,
                                    key: ValueKey(quote.id.toString() + 'a'),
                                  )
                                : IconTapButton(
                                    icon: Icons.favorite_border,
                                    key: ValueKey(quote.id.toString() + 'b'),
                                  ),
                          ),
                          onTap: () {
                            _favStore.switchFavs(quote);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          _quoteStore.setQuote(quote);
          Navigator.pushNamed(context, ShareQuote.id);
        },
      ),
    );
  }
}
