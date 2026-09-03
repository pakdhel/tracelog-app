import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tracelog_app/api/database_service.dart';
import 'package:tracelog_app/api/geocoding_service.dart';
import 'package:tracelog_app/api/geolocator_service.dart';
import 'package:tracelog_app/models/location_entry.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    print('====================================');
    print('🚀 WORKMANAGER START');
    print('Task: $task');
    print('Input: $inputData');

    try {
      print('Membuat services...');
      final geolocatorService = GeolocatorService();
      final geocodingService = GeocodingService();
      final databaseService = DatabaseService();
      final recordedAt = DateTime.now();

      print('Mengambil lokasi...');

      final position = await geolocatorService
          .getCurrentLocationByCoordinates(isBackground: true);

      print('📍Location: ${position.latitude}, ${position.longitude}');

      Placemark? placemark;

      try {
        print('Melakukan reverse geocoding...');

        final placemarks = await geocodingService.placemarks(
          position.latitude,
          position.longitude,
        );

        placemark = placemarks.isNotEmpty ? placemarks.first : null;

        print('🏠 Placemark: $placemark');
      } catch (e) {
        placemark = null;
      }

      print('Membuat LocationEntry...');

      final newEntry = LocationEntry(
        id: null,
        placemark: placemark,
        position: position,
        dateTime: recordedAt,
        isAutoTracked: true,
      );

      print('Menyimpan ke database...');

      final newId = await databaseService.insertItem(newEntry);
      newEntry.id = newId;

      print('✅ Location berhasil disimpan dengan ID: $newId');
      print('🏁 WORKMANAGER SUCCESS');
      print('====================================');

      return true;
    } catch (e, stackTrace) {
      print('❌ WORKMANAGER FAILED');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      print('====================================');

      return false;
    }
  });
}
