import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:tracelog_app/static/location_exception.dart';

class GeolocatorService {
  Future<void> checkLocationAcess() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationDisabledException(
        'Please enable location services to continue.',
      );
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionDeniedException(
          'Please allow location access to continue.',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedForeverException(
        'Location access is blocked. Please enable it from your device settings.',
      );
    }
  }

  Future<Position> getCurrentLocationByCoordinates() async {
    await checkLocationAcess();

    late LocationSettings locationSettings;

    if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    } else if (Platform.isIOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    } else {
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }
}
