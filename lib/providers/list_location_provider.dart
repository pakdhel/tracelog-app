import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tracelog_app/models/location_entry.dart';
import 'package:tracelog_app/providers/providers.dart';

class ListLocationNotifier extends AsyncNotifier<List<LocationEntry>> {
  @override
  Future<List<LocationEntry>> build() async {
    final database = ref.read(databaseServiceProvider);
    final listLocation = await database.getAllItems();
    return listLocation;
  }

  Future<void> addListLocation(bool isAutoTracked) async {
    final geolocatorService = ref.read(geolocatorServiceProvider);
    final geocodingService = ref.read(geocodingServiceProvider);
    final database = ref.read(databaseServiceProvider);
    final recordedAt = DateTime.now();

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final position = await geolocatorService
          .getCurrentLocationByCoordinates();

      Placemark? placemark;

      try {
        final placemarks = await geocodingService.placemarks(
          position.latitude,
          position.longitude,
        );
        placemark = placemarks.isNotEmpty ? placemarks.first : null;
      } catch (e) {
        placemark = null;
      }

      final currentList = state.value ?? [];
      final newEntry = LocationEntry(
        id: null,
        placemark: placemark,
        position: position,
        dateTime: recordedAt,
        isAutoTracked: isAutoTracked,
      );

      final newId = await database.insertItem(newEntry);
      newEntry.id = newId;

      return [newEntry, ...currentList];
    });
  }
}

final listLocationProvider =
    AsyncNotifierProvider<ListLocationNotifier, List<LocationEntry>>(() {
      return ListLocationNotifier();
    });
