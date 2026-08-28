import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracelog_app/providers/providers.dart';

class GeolocatorProvider extends AsyncNotifier<Position> {
  @override
  Future<Position> build() async {
    // TODO: implement build
    final service = ref.watch(geolocatorServiceProvider);
    await service.init();
    return service.getCurrentLocation();
  }

  Future<void> addLocationManually() async {
    state = const AsyncLoading();
    final service = ref.watch(geolocatorServiceProvider);
    state = await AsyncValue.guard(() => service.getCurrentLocation());
    print(state);
  }
}

final geolocatorProvider = AsyncNotifierProvider<GeolocatorProvider, Position>(
  GeolocatorProvider.new,
);
