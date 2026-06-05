// lib/screens/logbook/logbook_screen.dart
import 'package:flutter/material.dart';
import '../../models/catch_model.dart';

class LogbookScreen extends StatefulWidget {
  @override
  _LogbookScreenState createState() => _LogbookScreenState();
}

class _LogbookScreenState extends State<LogbookScreen> {
  String _selectedFilter = "Tous";
  
  final List<CatchModel> _catches = [
    CatchModel(
      photoUrl: "assets/placeholder.jpg",
      espece: "Bar Commun",
      tailleCm: 65,
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      tideStatus: "Montante",
      pressure: 1013,
      lat: 49.6, lon: -1.6,
    ),
    CatchModel(
      photoUrl: "assets/placeholder.jpg",
      espece: "Brochet",
      tailleCm: 82,
      timestamp: DateTime.now().subtract(Duration(days: 3)),
      tideStatus: "Eau Douce",
      pressure: 1020,
      lat: 48.8, lon: 2.3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF020617),
      appBar: AppBar(
        backgroundColor: Color(0xFF0F172A),
        title: Text("Mon Carnet", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            color: Color(0xFF0F172A),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip("Tous"),
                  _buildFilterChip("🌊 Marée Montante"),
                  _buildFilterChip("📉 Pression basse"),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _catches.length,
              itemBuilder: (context, index) => _buildCatchCard(_catches[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isActive = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(color: isActive ? Color(0xFF020617) : Colors.cyan, fontWeight: FontWeight.bold)),
        selected: isActive,
        selectedColor: Colors.cyan,
        backgroundColor: Color(0xFF1E293B),
        onSelected: (val) => setState(() => _selectedFilter = label),
      ),
    );
  }

  Widget _buildCatchCard(CatchModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Color(0xFF1E293B), borderRadius: BorderRadius.circular(20)),
        child: Column(
        children: [
          Container(
            height: 160, color: Color(0xFF0F172A), width: double.infinity, 
            alignment: Alignment.center,
            child: Icon(Icons.photo_camera_back, size: 48, color: Colors.white24),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.espece, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("${item.tailleCm} cm • ${item.tideStatus}", style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: Colors.cyan.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Text("${item.pressure} hPa", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}