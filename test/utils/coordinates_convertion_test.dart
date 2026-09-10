import 'package:flutter_test/flutter_test.dart';
import 'package:tracelog_app/utils/coordinates_convertion.dart';

void main() {
  test('lat dan long positif harusnya N dan E', () {
    double lat = 4;
    double lon = 120;

    String formattedCoordinates = CoordinatesConvertion.formattedCoordinates(
      lat,
      lon,
    );

    expect(formattedCoordinates, '4.0° N, 120.0° E');
  });

  test('lat negatif dan long positif harusnya S dan E', () {
    double lat = -4;
    double lon = 120;

    String formattedCoordinates = CoordinatesConvertion.formattedCoordinates(
      lat,
      lon,
    );

    expect(formattedCoordinates, '4.0° S, 120.0° E');
  });

  test('lat positif dan long negatif harusnya N dan W', () {
    double lat = 4;
    double lon = -120;

    String formattedCoordinates = CoordinatesConvertion.formattedCoordinates(
      lat,
      lon,
    );

    expect(formattedCoordinates, '4.0° N, 120.0° W');
  });

  test('lat dan long negatif harusnya S dan W', () {
    double lat = -4;
    double lon = -120;

    String formattedCoordinates = CoordinatesConvertion.formattedCoordinates(
      lat,
      lon,
    );

    expect(formattedCoordinates, '4.0° S, 120.0° W');
  });

  test('lat dan long Nol (0) harusnya N dan E', () {
    double lat = 0;
    double lon = 0;

    String formattedCoordinates = CoordinatesConvertion.formattedCoordinates(
      lat,
      lon,
    );

    expect(formattedCoordinates, '0.0° N, 0.0° E');
  });
}
