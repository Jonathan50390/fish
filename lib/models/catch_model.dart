// lib/models/catch_model.dart

class CatchModel {
  final String photoUrl;
  final String espece;
  final double tailleCm;
  final double? poidsKg;
  final DateTime timestamp;
  final double lat;
  final double lon;
  final double? temp;
  final int? pressure;
  final double? windSpeed;
  final String? tideStatus;
  final int? tideCoefficient;

  CatchModel({
    required this.photoUrl,
    this.espece = "Inconnue",
    this.tailleCm = 0.0,
    this.poidsKg,
    required this.timestamp,
    required this.lat,
    required this.lon,
    this.temp,
    this.pressure,
    this.windSpeed,
    this.tideStatus,
    this.tideCoefficient,
  });
}