import 'package:flutte_cuisine/Dashbord/accueil.dart';
import 'package:flutte_cuisine/Dashbord/ajouterrecette.dart';
import 'package:flutte_cuisine/Dashbord/ajouterrecette_seconde.dart';
import 'package:flutte_cuisine/Dashbord/recetteListedash.dart';
import 'package:flutte_cuisine/Dashbord/utilisateur.dart';
import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/Model/Utilisateur_Model.dart';
import 'package:flutter/material.dart';

class UtilProvider with ChangeNotifier {
  int _dashCurrentIndex = 0;
  Recette _recette = Recette();
  final List<Widget> _widgetOptions = <Widget>[
    const AccueilDashboard(),
    const ProfilePage(),
    const RecetteAjout(),
    AjouterRecetteDash(),
    const AjouterRecetteSecondePageDash()
  ];

  Utilisateur _utilisateur = const Utilisateur();

  Utilisateur get utilisateur => _utilisateur;

  int get dashboardCurrentIndex => _dashCurrentIndex;

  Recette get recette => _recette;

  List<Widget> get widgetOptions => _widgetOptions;

  void setUtilisateur(Utilisateur utilisateur) {
    _utilisateur = utilisateur;
    notifyListeners();
  }

  void setRecette(Recette recette) {
    _recette = recette;
    notifyListeners();
  }

  void setdashboardCurrentIndex(int val) {
    _dashCurrentIndex = val;
    notifyListeners();
  }

  int getIndex(Type className) {
    int indexRecetteAjout = 0;

    for (int i = 0; i < _widgetOptions.length; i++) {
      print(_widgetOptions[i].runtimeType == className);

      if (_widgetOptions[i].runtimeType == className) {
        indexRecetteAjout = i;
        break;
      }
    }

    print("L'index de RecetteAjout est : $indexRecetteAjout");
    return indexRecetteAjout;
  }
}
