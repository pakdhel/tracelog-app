import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationEntry {
  int? id;
  final Placemark? placemark;
  final Position position;
  final DateTime dateTime;
  final bool isAutoTracked;

  LocationEntry({
    this.id,
    required this.placemark,
    required this.position,
    required this.dateTime,
    required this.isAutoTracked,
  });

  factory LocationEntry.fromJson(Map<String, dynamic> json) {
    return LocationEntry(
      id: json['id'],
      placemark: json['street'] != null ? Placemark(street: json['street']) : null,
      position: Position(
        longitude: json['longitude'],
        latitude: json['latitude'],
        accuracy: json['accuracy'],
        timestamp: DateTime.parse(json['recordAt']),
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0
      ),
      dateTime: DateTime.parse(json['recordAt']),
      isAutoTracked: json['isAutoTracked'] == 1
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': placemark?.street,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'accuracy': position.accuracy,
      'recordAt': dateTime.toIso8601String(),
      'isAutoTracked': isAutoTracked ? 1 : 0,
    };
  }
}
