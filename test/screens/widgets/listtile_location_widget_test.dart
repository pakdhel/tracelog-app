import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracelog_app/models/location_entry.dart';
import 'package:tracelog_app/screens/widgets/listtile_location_widget.dart';

void main() {
  int? capturedValue;

  testWidgets(
    '''
    1.  Teks di placemark street harus sama dengan 
        teks yang muncul di Widget ListtileLocationWidget
    2.  Teks koordinat harusnya 0.0° N, 0.0° E jika lat dan lon adalah 0.0
    3.  Nilai yang tersimpan di capturedValue harus sama dengan location.id
        
        ''',
    (tester) async {
      final location = LocationEntry(
        placemark: Placemark(street: 'Jalan Urip Sumoharjo'),
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

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListtileLocationWidget(
                location: location,
                valueChanged: (value) {
                  capturedValue = value;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Jalan Urip Sumoharjo'), findsOneWidget);
      expect(find.text('0.0° N, 0.0° E'), findsOneWidget);

      await tester.longPress(find.byType(InkWell));
      await tester.pump();
      expect(capturedValue, location.id);
    },
  );
}
