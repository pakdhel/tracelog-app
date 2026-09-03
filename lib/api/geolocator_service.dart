import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:tracelog_app/static/location_exception.dart';

class GeolocatorService {
  Future<void> _checkLocationServiced() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationDisabledException(
        'Please enable location services to continue.',
      );
    }
  }

  Future<void> checkLocationAccess({bool isBackgroundRequired = false}) async {
    await _checkLocationServiced();

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionDeniedException(
          'Please allow location access to continue.',
        );
      }
    }

    if (isBackgroundRequired && permission == LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always) {        
        await Geolocator.openAppSettings();
        throw LocationPermissionDeniedException(
          'Background location permission ("Allow all the time") is required for auto tracking. Please enable it in Settings.',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      throw LocationPermissionDeniedForeverException(
        'Location access is blocked. Please enable it from your device settings.',
      );
    }
  }

  Future<void> checkBackgroundLocationAccess() async {
    await _checkLocationServiced();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedException(
        'Location permission not granted for background task.',
      );
    }
  }

  Future<Position> getCurrentLocationByCoordinates({
    bool isBackground = false,
  }) async {
    if (isBackground) {
      await checkBackgroundLocationAccess();
    } else {
      await checkLocationAccess();
    }

    late LocationSettings locationSettings;

    if (Platform.isAndroid) {
      locationSettings = AndroidSettings(accuracy: LocationAccuracy.high);
    } else if (Platform.isIOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
      );
    } else {
      locationSettings = LocationSettings(accuracy: LocationAccuracy.high);
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }
}
