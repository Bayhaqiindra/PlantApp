import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:praktikum8/components/my_bottom_nav_bar.dart';
import 'package:praktikum8/constants.dart';
import 'package:praktikum8/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const Body(),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }

AppBar _buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: kPrimaryColor, // <- Tambahkan warna di sini
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      onPressed: () {},
    ),
  );
}
}