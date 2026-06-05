// lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> _customMethods = [
    "Leurre Souple - Shad",
    "Traction Lourde 120g",
    "Tenkara",
    "Surfcasting posé"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF020617),
      appBar: AppBar(
        backgroundColor: Color(0xFF0F172A),
        title: Text("Mon Profil", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(radius: 40, backgroundColor: Colors.cyan, child: Icon(Icons.person, size: 40, color: Color(0xFF0F172A))),
                  SizedBox(height: 12),
                  Text("Alex_Pêche50", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("📍 Cherbourg • Membre Premium", style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text("PRÉFÉRENCES", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1)),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Color(0xFF0F172A), borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("📏 Système d'unités", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  Text("cm / kg", style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text("TECHNIQUES SUR-MESURE", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1)),
            SizedBox(height: 4),
            Text("Disponibles en raccourci lors de la capture.", style: TextStyle(color: Colors.white54, fontSize: 11)),
            SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
              itemCount: _customMethods.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: Color(0xFF0F172A), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_customMethods[index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(color: Color(0xFF1E293B), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.withOpacity(0.4), width: 1)),
              alignment: Alignment.center,
              child: Text("➕ Ajouter une technique", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}