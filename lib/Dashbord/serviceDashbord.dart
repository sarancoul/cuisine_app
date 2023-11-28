import 'dart:convert';

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
}
