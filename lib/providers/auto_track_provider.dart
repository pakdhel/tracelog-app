import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracelog_app/providers/providers.dart';
import 'package:workmanager/workmanager.dart';

class AutoTrackNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final sharedPrefernces = ref.read(sharePreferencesServiceProvider);
    return sharedPrefernces.getAutoTrack();
  }

  void toggleAutoTracking(bool value) async {
    final sharedPrefs = ref.read(sharePreferencesServiceProvider);
    final geolocator = ref.read(geolocatorServiceProvider);

    state = const AsyncLoading<bool>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      if (value) {
        await geolocator.checkLocationAccess(isBackgroundRequired: true);
      }
      await sharedPrefs.setAutoTrack(value);

      if (value) {
        await Workmanager().registerPeriodicTask(
          'fetch-location',
          'fetchLocationTask',
          initialDelay: Duration.zero,
          frequency: const Duration(minutes: 16),
          existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
          constraints: Constraints(
            networkType: NetworkType.notRequired,
          ),
        );
      } else {
        await Workmanager().cancelByUniqueName('fetch-location');
      }

      return value;
    });
  }
}

final autoTrackProvider = AsyncNotifierProvider<AutoTrackNotifier, bool>(() {
  return AutoTrackNotifier();
});
