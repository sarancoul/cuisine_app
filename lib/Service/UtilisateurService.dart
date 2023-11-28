import 'dart:convert';

import 'package:flutte_cuisine/Model/Utilisateur_Model.dart';
import 'package:http/http.dart' as http;

class UtilisateurService {
  static const apiUrl = 'http://localhost:8081/user';

  static Future<Utilisateur> createUser({
    required String nom,
    required String prenom,
    required String email,
    required String motdepasse,
    required String photo,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'motdepasse': motdepasse,
        'photo': photo,
      }),
    );
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return Utilisateur.fromJson(json);
    } else {
      throw Exception('Utilisateur non ajouter : ${response.statusCode}');
    }
  }

  //fonction pour la recuperation des utilisateur
  static Future<List<Utilisateur>> getAllUsers() async {
    final response = await http.get(Uri.parse('$apiUrl/all'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Utilisateur.fromJson(json)).toList();
    } else {
      throw Exception(
          'Impossible de recuperer les users : ${response.statusCode}');
    }
  }

  //fonction pour la modification 

  static Future<void> modifierUtilisateur(int id, Utilisateur utilisateur) async {
  final response = await http.put(Uri.parse('$apiUrl/update/$id'),
      headers: {"Content-Type": "application/json"},
      //body: jsonEncode(utilisateur.toJson())
      );

  if (response.statusCode == 200) {
    print('Utilisateur modifié avec succès');
  } else if (response.statusCode == 404) {
    print('Utilisateur non trouvé');
  } else {
    throw Exception('Impossible de modifier l\'utilisateur : ${response.statusCode}');
  }
}
  //fonction, pour la suppression
 static Future<void> supprimerUtilisateur(int id) async {
  final response = await http.delete(Uri.parse('$apiUrl/delete/$id'));

  if (response.statusCode == 200) {
    print('Utilisateur supprimé avec succès');
  } else if (response.statusCode == 404) {
    print('Utilisateur non trouvé');
  } else {
    throw Exception('Impossible de supprimer l\'utilisateur : ${response.statusCode}');
  }
}

static String getPhotoUrl(int userId) {
  return '$apiUrl/photo/$userId';
}


}
