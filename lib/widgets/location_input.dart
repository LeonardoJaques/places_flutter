import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_flutter/screens/map_screen.dart';
import 'package:places_flutter/utils/location_util.dart';

class LocationInput extends StatefulWidget {
  final Function(LatLng position) selectPosition;
  const LocationInput(this.selectPosition, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl = '';

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<void> _getCurrentUserLocation() async {
    await Geolocator.requestPermission();
    final Position position = await _geolocatorPlatform.getCurrentPosition();
    try {
      _showPreview(position.latitude, position.longitude);
      widget.selectPosition(LatLng(
        position.latitude,
        position.longitude,
      ));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    await Geolocator.requestPermission();
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(),
      ),
    );
    if (selectedPosition.latitude.isNaN || selectedPosition.longitude.isNaN) {
      return;
    }
    _showPreview(selectedPosition.latitude, selectedPosition.longitude);
    widget.selectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl.isEmpty
              ? const Text('No Location Chosen', textAlign: TextAlign.center)
              : Image.network(_previewImageUrl,
                  fit: BoxFit.cover, width: double.infinity),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Localização Atual'),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Selecionar no Mapa'),
              onPressed: _selectOnMap,
            ),
          ],
        )
      ],
    );
  }
}
