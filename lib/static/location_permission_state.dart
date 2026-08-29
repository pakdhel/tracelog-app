sealed class LocationException implements Exception {
  final String message;
  LocationException(this.message);
}

class LocationDisabledException extends LocationException {
  
  LocationDisabledException(super.message);
}

class LocationPermissionDeniedException extends LocationException {
  LocationPermissionDeniedException(super.message);
}

class LocationPermissionDeniedForeverException extends LocationException {
  LocationPermissionDeniedForeverException(super.message);
}
