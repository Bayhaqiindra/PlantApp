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

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  File? _imageFile;
  String? _selectedAddress; 

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final saved = await StorageHelper.saveImage(File(picked.path), 'gallery');
      setState(() => _imageFile = saved);
    }
  }

Future<void> _takePicture() async {
    await _requestPermissions();
    final File? result = await Navigator.push<File?>(
      context,
      MaterialPageRoute(builder: (_) => const CameraPage()),
    );
    if (result != null) {
      final saved = await StorageHelper.saveImage(result, 'camera');
      setState(() => _imageFile = saved);
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Pilih dari Galeri'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Gunakan Kamera'),
                  onTap: () {
                    Navigator.pop(context);
                    _takePicture();
                  },
                ),
              ],
            ),
          ),
    );
  }

Future<void> _openMapAndSelectAddress() async {
    final selectedAddress = await Navigator.push<String?>(
      context,
      MaterialPageRoute(builder: (_) => const MapPage()),
    );
    if (selectedAddress != null && selectedAddress.isNotEmpty) {
      setState(() {
        _selectedAddress = selectedAddress;
      });
    }
  }
