import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tracelog_app/api/database_service.dart';
import 'package:tracelog_app/models/location_entry.dart';

void main() {
  late DatabaseService databaseService;
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    databaseService = DatabaseService(databaseName: inMemoryDatabasePath);
  });

  test(
    '''
      DatabaseService.insertItem harusnya mengembalikan 
      id location jika berhasil menyimpan data ke database    
    ''',
    () async {
      final location = LocationEntry(
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
      );

      final result = await databaseService.insertItem(location);
      expect(result, greaterThan(0));
    },
  );

  test(
    '''
    1. Panjang list dari getAllItems harusnya sama dengan panjang list Locations yang di assign
    2. id dari index 0 getAllItems adalah id dari item terakhir di lis Locations
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

      final results = await Future.wait(
        locations.map((location) => databaseService.insertItem(location)),
      );

      final listResults = await databaseService.getAllItems();

      expect(results.length, locations.length);
      expect(listResults.length, locations.length);
      expect(listResults[0].placemark?.street, 'Jalan Manggarupi');
    },
  );

  test(
    '''
    1. Berhasil menghapus satu baris item
    2. Item yang dihapus benar benar hilang dari getAllItems
    ''',
    () async {
      final location = LocationEntry(
        placemark: Placemark(street: 'Jalan Jalan'),
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
      );

      final id = await databaseService.insertItem(location);
      final remove = await databaseService.removeItem(id);

      final listItems = await databaseService.getAllItems();
      final isRemoved = listItems.where((item) => item.id == id);

      expect(remove, 1);
      expect(isRemoved.length, 0);
    },
  );
}
