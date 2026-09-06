import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateFilterNotifier extends Notifier<DateTime?> {
  @override
  DateTime? build() {
    return null;
  }

  void selectDate(DateTime? date) {
    state = date;
  }
}

final dateFilterProvider = NotifierProvider<DateFilterNotifier, DateTime?>(() {
  return DateFilterNotifier();
});
