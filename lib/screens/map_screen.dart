import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_flutter/models/place.dart';

class MapScreen extends StatefulWidget {
  MapScreen(
      {this.initialLocation = const PlaceLocation(
        latitude: 37.4133961,
        longitude: -122.1225523,
      ),
      this.isReadonly = false,
      super.key});

  final PlaceLocation initialLocation;
  bool isReadonly = false;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione...'),
        actions: <Widget>[
          if (!widget.isReadonly)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _pickedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPosition);
                    },
            ),
        ],
      ),
      body: Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.initialLocation.latitude,
              widget.initialLocation.longitude,
            ),
            zoom: 16,
          ),
          onTap: widget.isReadonly ? null : _selectLocation,
          markers: _pickedPosition == null && !widget.isReadonly
              ? {}
              : {
                  Marker(
                    markerId: const MarkerId('p1'),
                    position: _pickedPosition ??
                        LatLng(
                          widget.initialLocation.latitude,
                          widget.initialLocation.longitude,
                        ),
                  ),
                },
        ),
      ),
    );
  }
}
