import 'package:geolocator/geolocator.dart';
import 'package:tracelog_app/api/geolocator_service.dart';

class FakeGeolocatorService implements GeolocatorService {
  @override
  Future<void> checkBackgroundLocationAccess() {
    throw UnimplementedError();
  }

  @override
  Future<void> checkLocationAccess({bool isBackgroundRequired = false}) {
    throw UnimplementedError();
  }

  @override
  Future<Position> getCurrentLocationByCoordinates({bool isBackground = false}) async {
    return Position(
      latitude: -6.2,
      longitude: 106.8,
      timestamp: DateTime.now(),
      accuracy: 10.0,
      altitude: 0.0,
      altitudeAccuracy: 0.0,
      heading: 0.0,
      headingAccuracy: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );
  }

  @override
  Future<void> openAppSettings() {
    // TODO: implement openAppSettings
    throw UnimplementedError();
  }
  
}