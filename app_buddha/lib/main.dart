import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import './screens/first.dart';
import './screens/quotes_list.dart';
import './screens/share_quote.dart';
import './stores/quote_store.dart';
import './stores/decoration_store.dart';
import './stores/favorities_store.dart';
import './stores/background_store.dart';

void main() => runApp(
      EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        // перезаписанная начальная локаль
        // startLocale: Locale('en', 'US'),
        startLocale: Locale('ru', 'RU'),
        useOnlyLangCode: true,
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<QuoteStore>(create: (_) => QuoteStore.create()),
        Provider<DecorationStore>(create: (_) => DecorationStore.create()),
        Provider<FavoritiesStore>(create: (_) => FavoritiesStore.create()),
        Provider<BackgroundStore>(create: (_) => BackgroundStore.create()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'appTitle'.tr(),
        debugShowCheckedModeBanner: false,
        initialRoute: First.id,
        routes: {
          First.id: (context) => First(),
          QuotesList.id: (context) => QuotesList(),
          ShareQuote.id: (context) => ShareQuote(),
        },
      ),
    );
  }
}
