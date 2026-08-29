import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationEntry {
  final DateTime dateTime;
  final Placemark? placemark;
  final Position position;

  LocationEntry({
    required this.placemark,
    required this.position,
    required this.dateTime,
  });
}
