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

String formatAddress(Placemark p) {
  final parts = <String>[];

  void addIfNotEmptyAndNotDuplicate(String? value) {
    if (value != null && value.isNotEmpty && !parts.contains(value)) {
      parts.add(value);
    }
  }

  addIfNotEmptyAndNotDuplicate(p.name);
  addIfNotEmptyAndNotDuplicate(p.street);
  addIfNotEmptyAndNotDuplicate(p.subLocality);
  addIfNotEmptyAndNotDuplicate(p.locality);
  addIfNotEmptyAndNotDuplicate(p.administrativeArea);
  addIfNotEmptyAndNotDuplicate(p.postalCode);
  addIfNotEmptyAndNotDuplicate(p.country);

  return parts.join(', ');
}

Future<void> _onTap(LatLng latlng) async {
    final placemarks = await placemarkFromCoordinates(
      latlng.latitude,
      latlng.longitude,
    );

    final p = placemarks.first;
    final address = formatAddress(p);

    setState(() {
      _pickedMarker = Marker(
        markerId: const MarkerId('picked'),
        position: latlng,
        infoWindow: InfoWindow(
          title: address.isNotEmpty ? address : 'Lokasi Dipilih',
          snippet: address.isNotEmpty
              ? address
              : 'Koordinat: ${latlng.latitude}, ${latlng.longitude}',
        ),
      );
    });

    final ctrl = await _ctrl.future;
    await ctrl.animateCamera(CameraUpdate.newLatLngZoom(latlng, 16));

    setState(() {
      _pickedAddress = address.isNotEmpty
          ? address
          : 'Koordinat: ${latlng.latitude}, ${latlng.longitude}';
    });
  }

void _confirmSelection() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi Alamat'),
        content: Text(_pickedAddress ?? ''),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, _pickedAddress);
            },
            child: const Text('Pilih'),
          ),
        ],
      ),
    );
  }
