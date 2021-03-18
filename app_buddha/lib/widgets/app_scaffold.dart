import 'package:flutter/material.dart';
import '../widgets/application_navigation_bar.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final int currentSelectedNavBarItem;
  final String title;
  final bool noAppBar;

  AppScaffold(
      {@required this.body,
      @required this.currentSelectedNavBarItem,
      this.title = "",
      this.noAppBar = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: noAppBar
          ? null
          : AppBar(
              title: Text(title),
            ),
      body: body,
      bottomNavigationBar: ApplicationNavigationBar(
        currentSelectedItem: currentSelectedNavBarItem,
      ),
    );
  }
}
