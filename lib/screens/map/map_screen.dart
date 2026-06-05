// lib/screens/map/map_screen.dart
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _activeFilter = "Tous";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B132B),
      body: Stack(
        children: [
          // Grille de fond de carte de simulation
          Positioned.fill(
            child: CustomPaint(painter: GridPainter()),
          ),
          // Marqueur d'exemple de spot secret
          Positioned(
            top: 350, left: 200,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
              child: Icon(Icons.lock, color: Color(0xFF0F172A), size: 16),
            ),
          ),
          // En-tête de contrôles
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: Color(0xFF0F172A), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.withOpacity(0.4))),
                    child: Text("📍 Filtre : $_activeFilter", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                  FloatingActionButton.small(
                    backgroundColor: Color(0xFF0F172A),
                    child: Icon(Icons.layers, color: Colors.cyan),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          // Panneau de spot inférieur
          Positioned(
            bottom: 20, left: 16, right: 16,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Color(0xFF0F172A), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.05))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("🔒 SPOT PRIVÉ", style: TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      SizedBox(height: 4),
                      Text("Spot aux Brochets", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Coordonnées sécurisées", style: TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan, foregroundColor: Color(0xFF0F172A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    child: Text("Y aller 🚀", style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90.0),
        child: FloatingActionButton(
          backgroundColor: Colors.cyan,
          child: Icon(Icons.add_location_alt, color: Color(0xFF0F172A)),
          onPressed: () {},
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.white.withOpacity(0.05)..strokeWidth = 1;
    for (double i = 0; i < size.width; i += 40) { canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint); }
    for (double i = 0; i < size.height; i += 40) { canvas.drawLine(Offset(0, i), Offset(size.width, i), paint); }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}