import 'dart:convert';

import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/Model/Utilisateur_Model.dart';
import 'package:http/http.dart' as http;

class dashbordService {
  static const apiUrl = 'http://localhost:8081/user';

  Future<List<Utilisateur>> getAllUsers() async {
    final response = await http.get(Uri.parse('$apiUrl/all'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Utilisateur.fromJson(json)).toList();
    } else {
      throw Exception(
          'Impossible de récupérer les utilisateurs : ${response.statusCode}');
    }
  }
  ///////////////////desactiver compte//////////////////////////////////

  static Future<void> desactiverCompte(int id) async {
    final response = await http.post(
      Uri.parse('http://localhost:8081/user/desactiver'),
      body: {'id': id.toString()},
    );
    if (response.statusCode == 200) {
      print('Compte désactivé avec succès');
    } else {
      print(
          'Erreur lors de la désactivation du compte : ${response.statusCode}');
    }
  }
///////////////////////////// activer compte//////////////////////////////////
  static Future<void> activerCompte(int id) async {
    final response = await http.post(
      Uri.parse('http://localhost:8081/user/activer'),
      body: {'id':id.toString() },
    );
    if(response.statusCode == 200){
      print('Compte activer avec succès');
    }else{
      print(
          'Erreur lors de la désactivation du compte : ${response.statusCode}');
    }
  }
////////////////recherche user ///////////////////////////////////////////
  
  static Future<List<Utilisateur>> searchUsersByName(String nom) async {
    final response = await http.get(Uri.parse('$apiUrl/chercher/nom?nom=$nom'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Utilisateur.fromJson(json)).toList();
    } else {
      throw Exception('Impossible de récupérer les utilisateurs : ${response.statusCode}');
    }
  }
/////////////##########recuperer les recettes #######///////////////////////////////////////////
static Future<List<Recette>> afficherrecettes() async {
  String baseUrl = 'http://localhost:8081/recette';
  String getRecetteUrl = '$baseUrl/all';

  try {
    print(Uri.parse(getRecetteUrl));
    final response = await http.get(Uri.parse(getRecetteUrl));
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      try {
        List<Recette> recettes =
            jsonData.map((data) => Recette.fromJson(data)).toList();

        return recettes; // Retournez la liste des recettes ici
      } catch (e) {
        print(e.toString());
        throw Exception('Erreur lors de la conversion des données.');
      }
    } else {
      throw Exception(
          'Erreur lors de la récupération des recettes: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Erreur lors de la récupération des recettes: $error');
  }
}

  void initializeRecettes() {}

}
