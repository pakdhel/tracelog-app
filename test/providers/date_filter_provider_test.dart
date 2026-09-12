import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracelog_app/providers/date_filter_provider.dart';

void main() {
  test('Nilai state awal dari dateFilterProvider adalah null', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final dateTimeState = container.read(dateFilterProvider);
    expect(dateTimeState, null);
  });

  test(
    '''
    DateTime yang di Assign ke provider 
    harus sama nilainya dengan state nya
    ''',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      DateTime dateTime = DateTime.now();
      container.read(dateFilterProvider.notifier).selectDate(dateTime);

      expect(container.read(dateFilterProvider), dateTime);
    },
  );

  test(
    '''
    null yang di Assign ke provider 
    harus sama nilainya dengan null
    ''',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      DateTime dateTime = DateTime.now();
      container.read(dateFilterProvider.notifier).selectDate(dateTime);

      container.read(dateFilterProvider.notifier).selectDate(null);

      expect(container.read(dateFilterProvider), null);
    },
  );
}
