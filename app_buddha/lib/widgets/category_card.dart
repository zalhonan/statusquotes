import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import '../models/models.dart';
import 'package:easy_localization/easy_localization.dart';
import '../services/category_inspired.dart';

class CategoryCard extends StatelessWidget {
  final QuoteCategory category;
  final Function onPressed;

  final RandomColor _randomColor = RandomColor();

  CategoryCard({@required this.category, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 10,
        child: TextButton(
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(4, 0, 0, 0),
            leading: CircleAvatar(
              backgroundColor:
                  _randomColor.randomColor(colorHue: ColorHue.blue),
              radius: 30,
              child: Text(
                category.emoji,
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            title: Text(
              categoryInspired(category.name),
            ),
            subtitle:
                Text('quotesInCategory'.tr() + category.amount.toString()),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
