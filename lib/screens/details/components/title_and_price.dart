import 'package:flutter/material.dart';
import 'package:praktikum8/constants.dart';

class TitleAndPrice extends StatelessWidget {
  const TitleAndPrice({
    Key? key,
    required this.title,
    required this.country,
    required this.price,
  }) : super(key: key);

  final String title;
  final String country;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title\n",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
                TextSpan(
                  text: country,
                  style: const TextStyle(
                    fontSize: 16,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            "\$$price",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: kPrimaryColor,
                  fontSize: 20, 
                ),
          ),
        ],
      ),
    );
  }
}
