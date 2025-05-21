import 'package:flutter/material.dart';
import 'package:praktikum8/constants.dart';
import 'package:praktikum8/screens/home/components/featurred_plants.dart';
import 'package:praktikum8/screens/home/components/header_with_seachbox.dart';
import 'package:praktikum8/screens/home/components/recomend_plants.dart';
import 'package:praktikum8/screens/home/components/title_with_more_bbtn.dart';


class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(
            title: "Recomended",
            press: _emptyPress,
          ),
          RecomendsPlants(),
          TitleWithMoreBtn(
            title: "Featured Plants",
            press: _emptyPress,
          ),
          FeaturedPlants(), 
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }

  static void _emptyPress() {}
}
