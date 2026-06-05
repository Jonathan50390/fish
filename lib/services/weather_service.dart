// lib/services/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  // Remplace ceci par ta clé gratuite OpenWeatherMap (https://home.openweathermap.org/api_keys)
  static const String _apiKey = "3b3c55a1fa47d221afb1100d206591b9";

  static Future<Map<String, dynamic>> getLiveWeather(double lat, double lon) async {
    if (_apiKey == "3b3c55a1fa47d221afb1100d206591b9") {
      print("⚠️ Clé API météo non configurée. Renvoi de données météo par défaut.");
      return {"temp": 15.2, "pressure": 1015, "windSpeed": 12.5};
    }

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$_apiKey"
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          "temp": data['main']['temp'].toDouble(),
          "pressure": data['main']['pressure'],
          "windSpeed": (data['wind']['speed'] * 3.6).toDouble(), // Conversion m/s en km/h
        };
      } else {
        throw Exception("Erreur HTTP: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Erreur API Météo : $e");
      return {"temp": 0.0, "pressure": 0, "windSpeed": 0.0};
    }
  }
}