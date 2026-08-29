import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracelog_app/api/geocoding_service.dart';
import 'package:tracelog_app/api/geolocator_service.dart';

final geolocatorServiceProvider = Provider<GeolocatorService>((ref) {
  return GeolocatorService();
});

final geocodingServiceProvider = Provider<GeocodingService>((ref) {
  return GeocodingService();
});
