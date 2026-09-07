import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveDeleteItemNotifier extends Notifier<int?> {
  @override
  int? build() {
    return null;
  }

  void setActiveItem(int? id) {
    state = id;
  }
}

final activeDeleteItemProvider =
    NotifierProvider<ActiveDeleteItemNotifier, int?>(() {
      return ActiveDeleteItemNotifier();
    });
