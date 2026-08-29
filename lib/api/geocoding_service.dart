import 'package:geocoding/geocoding.dart';

class GeocodingService {
  Geocoding geocoding = Geocoding();

  Future<List<Placemark>> placemarks(double latitude, double longitude) async {
    return await geocoding.placemarkFromCoordinates(latitude, longitude);
  }
}
