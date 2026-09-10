import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracelog_app/models/location_entry.dart';

void main() {
  test('LocationEntry.fromMap harus parse data dengan benar', () {
    final json = {
      'id': 1,
      'street': 'Jalan Adi sucipto',
      'latitude': 0.0,
      'longitude': 0.0,
      'accuracy': 0.0,
      'recordAt': '1969-07-20 20:18:04Z',
      'isAutoTracked': 0,
    };

    final location = LocationEntry.fromJson(json);

    expect(location.id, json['id']);
    expect(location.placemark?.street, json['street']);
    expect(location.position.latitude, json['latitude']);
    expect(location.position.longitude, json['longitude']);
    expect(location.position.accuracy, json['accuracy']);
    expect(location.dateTime, DateTime.parse('1969-07-20 20:18:04Z'));
    expect(location.isAutoTracked, false);
  });

  test(
    'LocationEntry.fromMap harus menghasilkan placemark null jika street null',
    () {
      final json = {
        'id': 2,
        'street': null,
        'latitude': 0.0,
        'longitude': 0.0,
        'accuracy': 0.0,
        'recordAt': '1969-07-20 20:18:04Z',
        'isAutoTracked': 1,
      };

      final location = LocationEntry.fromJson(json);

      expect(location.placemark, null);
      expect(location.isAutoTracked, true);
    },
  );

  group('LocationEntry.toJson test', () {
    final location = LocationEntry(
      id: 1,
      placemark: null,
      position: Position(
        longitude: 0.0,
        latitude: 0.0,
        accuracy: 0.0,
        timestamp: DateTime.parse('1969-07-20 20:18:04Z'),
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      ),
      dateTime: DateTime.parse('1969-07-20 20:18:04Z'),
      isAutoTracked: true,
    );
    test(
      '''
      LocationEntry.toJson harus mengonversi isAutoTracked true jadi 1 
      dan json['street'] bernilai null jika placemark null
      ''',
      () {
        final json = location.toJson();

        expect(json['isAutoTracked'], 1);
        expect(json['street'], null);
        expect(json['recordAt'], location.dateTime.toIso8601String());
      },
    );

    test(
      'toJson harus mengonversi isAutoTracked false menjadi 0 dan street terisi',
      () {
        final locationWithPlacemark = LocationEntry(
          id: 2,
          placemark: Placemark(street: 'Jalan Sudirman'),
          position: location.position, 
          dateTime: location.dateTime,
          isAutoTracked: false,
        );

        final json = locationWithPlacemark.toJson();

        expect(json['isAutoTracked'], 0);
        expect(json['street'], 'Jalan Sudirman');
      },
    );
  });
}
