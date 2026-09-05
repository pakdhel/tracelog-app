import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPreviewWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  const MapPreviewWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(latitude, longitude),
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.tracelog_app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              rotate: true,
              point: LatLng(latitude, longitude),
              child: Icon(Icons.location_on_sharp, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
