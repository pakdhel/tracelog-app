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

  Duration _calculateInitialDelay(int targetHour, int targetMinute) {
    final now = DateTime.now();
    DateTime scheduleTime = DateTime(
      now.year,
      now.month,
      now.day,
      targetHour,
      targetMinute,
    );

    if (now.isAfter(scheduleTime)) {
      scheduleTime = scheduleTime.add(const Duration(days: 1));
    }

    return scheduleTime.difference(now);
  }

  void toggleAutoTracking(bool value) async {
    final sharedPrefs = ref.read(sharePreferencesServiceProvider);
    final geolocator = ref.read(geolocatorServiceProvider);

    state = const AsyncLoading<bool>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      await geolocator.checkLocationAcess();
      await sharedPrefs.setAutoTrack(value);
      return value;
    });
  }
}

final autoTrackProvider = AsyncNotifierProvider<AutoTrackNotifier, bool>(() {
  return AutoTrackNotifier();
});
