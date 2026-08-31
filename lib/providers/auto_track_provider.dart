import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracelog_app/providers/providers.dart';

class AutoTrackNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final sharedPrefernces = ref.read(sharePreferencesServiceProvider);
    return sharedPrefernces.getAutoTrack();
  }

  void toggleAutoTracking(bool value) async {
    final isAutoTrack = state.value;
    final sharedPrefs = ref.read(sharePreferencesServiceProvider);

    if (isAutoTrack != null && isAutoTrack != value) {
      await sharedPrefs.setAutoTrack(value);
      state = AsyncValue.data(value);
    }
  }
}

final autoTrackProvider = AsyncNotifierProvider<AutoTrackNotifier, bool>(() {
  return AutoTrackNotifier();
});
