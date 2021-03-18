import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/colors.dart';
import '../screens/first.dart';
import '../screens/quotes_list.dart';
import '../screens/share_quote.dart';
import '../screens/favorities.dart';

const appNavigationHeight = 73.0;

class ApplicationNavigationBar extends StatefulWidget {
  final int currentSelectedItem;

  const ApplicationNavigationBar({Key key, @required this.currentSelectedItem})
      : super(key: key);

  @override
  _ApplicationNavigationBarState createState() =>
      _ApplicationNavigationBarState(currentSelectedItem: currentSelectedItem);
}

class _ApplicationNavigationBarState extends State<ApplicationNavigationBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentSelectedItem;

  _ApplicationNavigationBarState({@required int currentSelectedItem})
      : _currentSelectedItem = currentSelectedItem;

  @override
  Widget build(BuildContext context) {
    Color _mainBarColor = kColorLightPrimary;
    Color _iconActive = kColorAccent;
    Color _iconNotActive = kColorDarkPrimary;

    return Material(
      color: _mainBarColor,
      child: TabBar(
        controller: _tabController,
        // в целях совместимости в Web: SvgIcons заменены на FontAwesome
        tabs: [
          Tab(
            icon: Icon(
              FontAwesomeIcons.listOl,
              color: _currentSelectedItem == 0 ? _iconActive : _iconNotActive,
            ),
          ),
          Tab(
            icon: Icon(
              FontAwesomeIcons.quoteLeft,
              color: _currentSelectedItem == 1 ? _iconActive : _iconNotActive,
            ),
          ),
          Tab(
            icon: Icon(
              FontAwesomeIcons.shareSquare,
              color: _currentSelectedItem == 2 ? _iconActive : _iconNotActive,
            ),
          ),
          Tab(
            icon: Icon(
              FontAwesomeIcons.heart,
              color: _currentSelectedItem == 3 ? _iconActive : _iconNotActive,
            ),
          ),
        ],
        onTap: (index) {
          if (index == 0 &&
              _tabController.previousIndex != _tabController.index) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => First(),
              ),
            );
            // добавлена навигация в сетку коктейлей FilterResultsPageWidget
          } else if (index == 1 &&
              _tabController.previousIndex != _tabController.index) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => QuotesList(),
              ),
            );
            // добавлена навигация в random cocktail
          } else if (index == 2 &&
              _tabController.previousIndex != _tabController.index) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => ShareQuote(),
              ),
            );
          } else if (index == 3 &&
              _tabController.previousIndex != _tabController.index) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => Favorities(),
              ),
            );
          } else {
            setState(() {
              _currentSelectedItem = index;
            });
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: _currentSelectedItem, length: 4, vsync: this);
  }
}
