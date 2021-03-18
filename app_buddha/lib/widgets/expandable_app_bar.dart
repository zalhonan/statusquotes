import 'package:flutter/material.dart';
import '../services/constants.dart';

class ExpandableAppBar extends StatelessWidget {
  ExpandableAppBar({
    @required this.title,
    @required this.backgroundImage,
    @required this.backgroundColor,
    this.index,
    this.controller,
    this.noBackButton = false,
    this.expandedHeight = kExpandedAppBarHeight,
  });

  final ScrollController controller;
  final String title;
  final double index;
  final ImageProvider backgroundImage;
  final Color backgroundColor;
  final bool noBackButton;
  final double expandedHeight;

  void tapFunction() {
    if (index != null && controller != null) {
      controller.animateTo(index,
          duration: Duration(milliseconds: 1000), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // floating: true - бар будет появляться при любом перемещении списка вниз
      title: GestureDetector(onTap: tapFunction, child: Text(title)),
      // pinned - остается запиненным при скролле
      pinned: true,

      automaticallyImplyLeading: noBackButton ? false : true,

      backgroundColor: backgroundColor,
      // первоначальная высота
      expandedHeight: expandedHeight,

      // раскрывающийся бар с картинкой
      flexibleSpace: GestureDetector(
        onTap: tapFunction,
        child: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Image(
            fit: BoxFit.cover,
            image: backgroundImage,
          ),
        ),
      ),
    );
  }
}
