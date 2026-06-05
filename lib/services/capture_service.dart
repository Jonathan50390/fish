// lib/services/capture_service.dart
import 'package:geolocator/geolocator.dart';
import '../models/catch_model.dart';
import 'weather_service.dart';

class CaptureService {
  Future<CatchModel> createRealCatch({required String photoPath, required String espece}) async {
    // 1. Vérification des permissions GPS
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Le service GPS est désactivé sur l'appareil.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permission GPS refusée.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Permission GPS refusée définitivement.");
    }

    print("🛰️ Acquisition de la position GPS haute précision en cours...");
    // 2. Récupération de la position physique
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    print("☁️ Récupération de la météo en direct pour Lat: ${position.latitude}...");
    // 3. Appel de la météo en direct avec les coordonnées exactes
    final weather = await WeatherService.getLiveWeather(position.latitude, position.longitude);

    return CatchModel(
      photoUrl: photoPath,
      espece: espece,
      tailleCm: 0.0, // À compléter par l'utilisateur ou l'IA plus tard
      timestamp: DateTime.now(),
      lat: position.latitude,
      lon: position.longitude,
      temp: weather['temp'],
      pressure: weather['pressure'],
      windSpeed: weather['windSpeed'],
      tideStatus: "Auto (Marée)", // Placeholder marin
      tideCoefficient: 80,
    );
  }
}