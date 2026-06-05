// lib/screens/dashboard/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../services/weather_service.dart';
import '../../widgets/smart_mode_switch.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isSeaMode = true;
  bool _isLoading = true;
  String _locationStatus = "Recherche GPS...";
  double _currentTemp = 0.0;
  int _currentPressure = 0;
  double _currentWind = 0.0;

  @override
  void initState() {
    super.initState();
    _loadRealLiveEnvironment();
  }

  Future<void> _loadRealLiveEnvironment() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium
        );

        final weather = await WeatherService.getLiveWeather(pos.latitude, pos.longitude);

        if (mounted) {
          setState(() {
            _locationStatus = "GPS Actif (${pos.latitude.toStringAsFixed(2)})";
            _currentTemp = weather['temp'] ?? 0.0;
            _currentPressure = weather['pressure'] ?? 0;
            _currentWind = weather['windSpeed'] ?? 0.0;
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _locationStatus = "GPS Refusé";
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Erreur initialisation Dashboard : $e");
      setState(() {
        _locationStatus = "Erreur GPS";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartModeSwitch(onModeChanged: (val) => setState(() => _isSeaMode = val)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("CONDITIONS EN DIRECT", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 12)),
                  Text(_locationStatus, style: const TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              _isLoading 
                ? const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator(color: Colors.cyan)))
                : GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      _buildWidget("MÉTÉO", "${_currentTemp.toStringAsFixed(1)}°C", Icons.cloud),
                      _buildWidget("VENT", "${_currentWind.toStringAsFixed(0)} km/h", Icons.wind_power),
                      _buildWidget("PRESSION", "$_currentPressure hPa", Icons.speed),
                      _isSeaMode 
                        ? _buildWidget("MARÉE", "Montante (82)", Icons.water)
                        : _buildWidget("LUNE", "Gibbeuse (75%)", Icons.nightlight_round),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidget(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.cyan, size: 28),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}