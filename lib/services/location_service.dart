import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position?> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return null;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return null;
    }

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (_) {
      return null;
    }
  }

  static Future<String?> getCurrentAddress() async {
    final position = await getCurrentPosition();
    if (position == null) return null;

    try {
      final places = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (places.isEmpty) return null;

      final p = places.first;
      return [
        p.name,
        p.street,
        p.subLocality,
        p.locality,
        p.administrativeArea,
        p.postalCode,
      ].whereType<String>().where((e) => e.trim().isNotEmpty).join(', ');
    } catch (_) {
      return null;
    }
  }
}
