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
    final isAutoTrack = state.value;
    final sharedPrefs = ref.read(sharePreferencesServiceProvider);

    if (isAutoTrack != null && isAutoTrack != value) {
      await sharedPrefs.setAutoTrack(value);
      state = AsyncValue.data(value);
    }

    if (value) {
      final initialDelay = _calculateInitialDelay(5, 0);
      try {
        await Workmanager().registerPeriodicTask(
          '1',
          'autoTrackingTask',
          initialDelay: initialDelay,
          frequency: const Duration(minutes: 20),
          existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
        );

        print('task berhasil didaftarkan');
      } catch (e) {
        print('task gagal didaftarkan');
      }
    } else {
      Workmanager().cancelByUniqueName('1');
    }
  }
}

final autoTrackProvider = AsyncNotifierProvider<AutoTrackNotifier, bool>(() {
  return AutoTrackNotifier();
});
