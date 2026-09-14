import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tracelog_app/api/database_service.dart';
import 'package:tracelog_app/models/location_entry.dart';
import 'package:tracelog_app/providers/list_location_provider.dart';
import 'package:tracelog_app/providers/providers.dart';

void main() {
  late DatabaseService databaseService;
  late ProviderContainer container;
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    databaseService = DatabaseService(databaseName: inMemoryDatabasePath);
    container = ProviderContainer(
      overrides: [databaseServiceProvider.overrideWithValue(databaseService)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    '''
    Memastikan bahwa build() di ListLocationNotifier 
    memanggil data dari database
    ''',
    () async {
      final List<LocationEntry> locations = [
        LocationEntry(
          placemark: Placemark(street: 'Jalan Urip'),
          position: Position(
            longitude: 0.0,
            latitude: 0.0,
            timestamp: DateTime.now(),
            accuracy: 0.0,
            altitude: 0.0,
            altitudeAccuracy: 0.0,
            heading: 0.0,
            headingAccuracy: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
          ),
          dateTime: DateTime.now(),
          isAutoTracked: false,
        ),
        LocationEntry(
          placemark: Placemark(street: 'Jalan Pettarani'),
          position: Position(
            longitude: 0.0,
            latitude: 0.0,
            timestamp: DateTime.now(),
            accuracy: 0.0,
            altitude: 0.0,
            altitudeAccuracy: 0.0,
            heading: 0.0,
            headingAccuracy: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
          ),
          dateTime: DateTime.now(),
          isAutoTracked: false,
        ),
        LocationEntry(
          placemark: Placemark(street: 'Jalan Manggarupi'),
          position: Position(
            longitude: 0.0,
            latitude: 0.0,
            timestamp: DateTime.now(),
            accuracy: 0.0,
            altitude: 0.0,
            altitudeAccuracy: 0.0,
            heading: 0.0,
            headingAccuracy: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
          ),
          dateTime: DateTime.now(),
          isAutoTracked: false,
        ),
      ];

      await Future.wait(
        locations.map((location) => databaseService.insertItem(location)),
      );

      final listLocation = await container.read(listLocationProvider.future);

      expect(listLocation[0].placemark?.street, locations[2].placemark?.street);
      expect(listLocation[1].placemark?.street, locations[1].placemark?.street);
      expect(listLocation[2].placemark?.street, locations[0].placemark?.street);
    },
  );
}
