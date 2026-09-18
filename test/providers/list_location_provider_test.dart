import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tracelog_app/api/database_service.dart';
import 'package:tracelog_app/api/geocoding_service.dart';
import 'package:tracelog_app/api/geolocator_service.dart';
import 'package:tracelog_app/models/location_entry.dart';
import 'package:tracelog_app/providers/list_location_provider.dart';
import 'package:tracelog_app/providers/providers.dart';

import 'fake_geocoding_service.dart';
import 'fake_geolocator_service.dart';

void main() {
  late DatabaseService databaseService;
  late ProviderContainer container;
  late GeolocatorService geolocatorService;
  late GeocodingService geocodingService;
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    databaseService = DatabaseService(databaseName: inMemoryDatabasePath);
    geolocatorService = FakeGeolocatorService();
    geocodingService = FakeGeocodingService();
    container = ProviderContainer(
      overrides: [
        databaseServiceProvider.overrideWithValue(databaseService),
        geolocatorServiceProvider.overrideWithValue(geolocatorService),
        geocodingServiceProvider.overrideWithValue(geocodingService),
      ],
    );
  });

  tearDown(() async {
    await databaseService.closeDb();
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

      await databaseService.insertItem(locations[0]);
      await databaseService.insertItem(locations[1]);
      await databaseService.insertItem(locations[2]);

      final listLocation = await container.read(listLocationProvider.future);

      expect(listLocation[0].placemark?.street, locations[2].placemark?.street);
      expect(listLocation[1].placemark?.street, locations[1].placemark?.street);
      expect(listLocation[2].placemark?.street, locations[0].placemark?.street);
    },
  );

  test(
    'Memastikan bahwa addListLocation menambahkan fake lokasi ke list',
    () async {
      await container
          .read(listLocationProvider.notifier)
          .addListLocation(false);
      final list = await container.read(listLocationProvider.future);
      expect(list.length, 1);
      expect(list.first.placemark?.street, "Jl Urip");
      expect(list.first.position.latitude, -6.2);
      expect(list.first.position.longitude, 106.8);
      expect(list.first.position.accuracy, 10.0);
    },
  );

  test(
    '''
    Memastikan removeLocationById berhasil menghapus 
    satu item lokasi berdasarkan id dari list
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

      final idPertama = await databaseService.insertItem(locations[0]);
      await databaseService.insertItem(locations[1]);
      await databaseService.insertItem(locations[2]);

      await container
          .read(listLocationProvider.notifier)
          .removeLocationById(idPertama);

      final listLocations = await container.read(listLocationProvider.future);

      final contains = listLocations
          .where((test) => test.id == idPertama)
          .toList();

      // expect(listLocations[0].id, 3);
      // expect(listLocations[1].id, 2);
      expect(contains.length, 0);
      expect(listLocations.length, 2);
    },
  );
}
