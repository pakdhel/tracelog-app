import 'package:flutter_test/flutter_test.dart';
import 'package:tracelog_app/utils/date_helper.dart';

void main() {
  test('tanggal sama beda jam harusnya true', () {
    DateTime dateTime1 = DateTime(2026, 9, 10, 8);
    DateTime dateTime2 = DateTime(2026, 9, 10, 9);

    bool isNotSame = dateTime1.isSameDate(dateTime2);
    expect(isNotSame, true);
  });

  test('perbedaan tanggal harusnya false', () {
    DateTime dateTime1 = DateTime(2026, 4, 17, 8);
    DateTime dateTime2 = DateTime(2026, 9, 10, 9);

    bool isSame = dateTime1.isSameDate(dateTime2);
    expect(isSame, false);
  });

  test('berpindah hari harusnya false', () {
    DateTime dateTime1 = DateTime(2026, 9, 10, 23, 59);
    DateTime dateTime2 = DateTime(2026, 9, 11, 0, 1);

    bool isNotSame = dateTime1.isSameDate(dateTime2);
    expect(isNotSame, false);
  });
}
