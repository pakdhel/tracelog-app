import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracelog_app/api/geolocator_service.dart';

final geolocatorServiceProvider = Provider<GeolocatorService>((ref) {
  return GeolocatorService();
});


