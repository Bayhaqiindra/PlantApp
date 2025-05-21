import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _ctrl = Completer();
  Marker? _pickedMarker;
  String? _pickedAddress;
  String? _currentAddress;
  CameraPosition? _initialCamera;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _setupLocation();
  }

  Future<void> _setupLocation() async {
    try {
      final pos = await getPermissions();
      _currentPosition = pos;
      _initialCamera = CameraPosition(
        target: LatLng(pos.latitude, pos.longitude),
        zoom: 16,
      );

      final placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      final p = placemarks.first;
      final formattedAddress = formatAddress(p);
      _currentAddress = formattedAddress.isNotEmpty
          ? formattedAddress
          : 'Koordinat: ${pos.latitude}, ${pos.longitude}';

      setState(() {});
    } catch (e) {
      _initialCamera = const CameraPosition(target: LatLng(0, 0), zoom: 21);
      setState(() {});
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

Future<Position> getPermissions() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw 'Location service belum aktif';
    }

    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();

      if (perm == LocationPermission.denied) {
        throw 'Izin lokasi ditolak';
      }
      if (perm == LocationPermission.deniedForever) {
        throw 'Izin lokasi ditolak permanen';
      }
    }

    return Geolocator.getCurrentPosition();
  }

