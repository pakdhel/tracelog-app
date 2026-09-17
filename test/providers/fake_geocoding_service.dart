import 'package:geocoding/geocoding.dart';
import 'package:tracelog_app/api/geocoding_service.dart';

class FakeGeocodingService implements GeocodingService {
  @override
  late Geocoding geocoding;

  @override
  Future<List<Placemark>> placemarks(double latitude, double longitude) async {
    List<Placemark> list = [Placemark(street: "Jl Urip")];
    return list;
  }
}
