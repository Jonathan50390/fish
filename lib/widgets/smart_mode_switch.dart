// lib/widgets/smart_mode_switch.dart
import 'package:flutter/material.dart';

class SmartModeSwitch extends StatefulWidget {
  final Function(bool isSeaMode) onModeChanged;

  const SmartModeSwitch({Key? key, required this.onModeChanged}) : super(key: key);

  @override
  _SmartModeSwitchState createState() => _SmartModeSwitchState();
}

class _SmartModeSwitchState extends State<SmartModeSwitch> {
  bool _isSeaMode = true;
  bool _isAutoDetected = true;
  String _currentLocation = "Cherbourg-en-Cotentin";

  void _toggleMode(bool forceSea) {
    setState(() {
      _isSeaMode = forceSea;
      _isAutoDetected = false;
    });
    widget.onModeChanged(_isSeaMode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.cyan, size: 16),
                  SizedBox(width: 6),
                  Text(_currentLocation, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _isAutoDetected ? Colors.cyan.withOpacity(0.1) : Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _isAutoDetected ? "Auto-détecté" : "Mode Manuel",
                  style: TextStyle(color: _isAutoDetected ? Colors.cyan : Colors.amber, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 44,
            decoration: BoxDecoration(color: Color(0xFF0F172A), borderRadius: BorderRadius.circular(22)),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _toggleMode(true),
                    child: Container(
                      decoration: BoxDecoration(color: _isSeaMode ? Colors.cyan : Colors.transparent, borderRadius: BorderRadius.circular(22)),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("🌊", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 8),
                          Text("Mer", style: TextStyle(color: _isSeaMode ? Color(0xFF0F172A) : Colors.white54, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _toggleMode(false),
                    child: Container(
                      decoration: BoxDecoration(color: !_isSeaMode ? Colors.cyan : Colors.transparent, borderRadius: BorderRadius.circular(22)),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("🍃", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 8),
                          Text("Eau Douce", style: TextStyle(color: !_isSeaMode ? Color(0xFF0F172A) : Colors.white54, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}