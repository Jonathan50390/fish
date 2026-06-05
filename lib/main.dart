// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/logbook/logbook_screen.dart';
import 'screens/map/map_screen.dart';
import 'screens/profile/profile_screen.dart';

void main() {
  runApp(FishLogApp());
}

class FishLogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FishLog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan,
        scaffoldBackgroundColor: Color(0xFF020617),
      ),
      home: AppRootSwitcher(),
    );
  }
}

class AppRootSwitcher extends StatefulWidget {
  @override
  _AppRootSwitcherState createState() => _AppRootSwitcherState();
}

class _AppRootSwitcherState extends State<AppRootSwitcher> {
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn 
      ? MainNavigationHub() 
      : LoginScreen(onLoginSuccess: () => setState(() => _isLoggedIn = true));
  }
}

class MainNavigationHub extends StatefulWidget {
  @override
  _MainNavigationHubState createState() => _MainNavigationHubState();
}

class _MainNavigationHubState extends State<MainNavigationHub> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    MapScreen(),
    Container(), // Espace vide réservé pour le FAB central
    LogbookScreen(),
    ProfileScreen(),
  ];

  void _triggerCaptureFlow() {
    // Affiche une simulation d'alerte ou ouvre la caméra
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("📸 Déclenchement de la capture IA & GPS..."),
        backgroundColor: Colors.cyan,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _triggerCaptureFlow,
        backgroundColor: Colors.cyan,
        elevation: 8,
        child: Icon(Icons.add_a_photo, color: Color(0xFF020617)),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF0F172A),
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.dashboard_outlined, "Home"),
              _buildNavItem(1, Icons.map_outlined, "Carte"),
              SizedBox(width: 40),
              _buildNavItem(3, Icons.book_outlined, "Carnet"),
              _buildNavItem(4, Icons.person_outline, "Profil"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? Colors.cyan : Colors.white54, size: 22),
          SizedBox(height: 2),
          Text(label, style: TextStyle(color: isActive ? Colors.cyan : Colors.white54, fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}