import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:praktikum8/camera_page.dart';
import 'package:praktikum8/constants.dart';
import 'package:praktikum8/map_page.dart';
import 'package:praktikum8/storage_helper.dart';

class HeaderWithSearchBox extends StatefulWidget {
  final Size size;

  const HeaderWithSearchBox({super.key, required this.size});

  @override
  State<HeaderWithSearchBox> createState() => _HeaderWithSearchBoxState();
}


