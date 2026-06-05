// lib/screens/auth/login_screen.dart
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  const LoginScreen({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: "pecheur.passionne@gmail.com");
  final _passwordController = TextEditingController(text: "password123");

  void _signIn() {
    // Remplacer par l'authentification Firebase réelle
    widget.onLoginSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("FishLog", style: TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email", 
                labelStyle: TextStyle(color: Colors.cyan),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan.withOpacity(0.4)), borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan), borderRadius: BorderRadius.circular(12)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Mot de passe", 
                labelStyle: TextStyle(color: Colors.cyan),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan.withOpacity(0.4)), borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan), borderRadius: BorderRadius.circular(12)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Color(0xFF0F172A),
                minimumSize: Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
              ),
              child: Text("Se connecter", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}