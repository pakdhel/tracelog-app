class CoordinatesConvertion {
  static String formattedCoordinates(double lattitude, double longitude) {
    String latDirection = lattitude >= 0 ? 'N' : 'S';
    double formattedLat = lattitude.abs();

    String longDirection = longitude >= 0 ? 'E' : 'W';
    double formattedLong = longitude.abs();

    return '$formattedLat° $latDirection, $formattedLong° $longDirection';
  }
}
