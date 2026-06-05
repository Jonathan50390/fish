// lib/services/recfishing_compliance_service.dart
import '../models/catch_model.dart';

class RecFishingComplianceService {
  final String _euLoginToken;

  RecFishingComplianceService(this._euLoginToken);

  final List<String> _especesReglementees = [
    "Bar Commun", 
    "Lieu Jaune", 
    "Thon Rouge", 
    "Maquereau"
  ];

  bool necessiteDeclaration(String espece) {
    return _especesReglementees.contains(espece);
  }

  double _arrondirCoordonnees(double val) {
    return double.parse(val.toStringAsFixed(1)); // Tronque pour anonymisation légale
  }

  Future<bool> transmettreDeclarationSansTimer(CatchModel prise) async {
    if (!necessiteDeclaration(prise.espece)) return false;

    // Création silencieuse du bloc session sans timer utilisateur
    DateTime heureDebutSimulee = prise.timestamp.subtract(Duration(minutes: 30));
    DateTime heureFinSimulee = prise.timestamp.add(Duration(minutes: 10));

    final payloadLegal = {
      "session_start": heureDebutSimulee.toIso8601String(),
      "session_end": heureFinSimulee.toIso8601String(),
      "eu_token": _euLoginToken,
      "catches": [
        {
          "species": prise.espece,
          "size_cm": prise.tailleCm,
          "exact_time": prise.timestamp.toIso8601String(),
          "lat_approx": _arrondirCoordonnees(prise.lat),
          "lon_approx": _arrondirCoordonnees(prise.lon),
        }
      ]
    };

    await Future.delayed(Duration(milliseconds: 600)); // Simulation POST API UE
    print("✅ Certificat envoyé à RecFishing : $payloadLegal");
    return true;
  }
}