import 'package:flutter/material.dart';
import 'package:praktikum8/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);  // Tambahkan const constructor dan key

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),  // Karena Body() kemungkinan widget stateless, bisa const juga untuk performa lebih baik
    );
  }
}
