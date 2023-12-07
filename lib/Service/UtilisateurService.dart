import 'dart:convert';

import 'package:flutte_cuisine/Model/Utilisateur_Model.dart';
import 'package:flutte_cuisine/Model/authentification.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:http/http.dart' as http;

class UtilisateurService {
  // static const apiUrl = 'http://localhost:8081/user';

  static Future<Utilisateur> authentification(
      {required Authentification authentification, required String url}) async {
    print(authentification.toJson());
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(authentification.toJson()),
    );
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print("--------------------------------------------------------");
      return Utilisateur.fromJson(json);
    } else {
      throw Exception('Utilisateur non ajouter : ${response.statusCode}');
    }
  }

  static Future<Utilisateur> createUser({
    required String nom,
    required String prenom,
    required String email,
    required String motdepasse,
    required String photo,
  }) async {
    print(apiUrl);
    final response = await http.post(
      Uri.parse('${apiUrl}user/create'),
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
    final response = await http.get(Uri.parse('$apiUrl/user/all'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Utilisateur.fromJson(json)).toList();
    } else {
      throw Exception(
          'Impossible de recuperer les users : ${response.statusCode}');
    }
  }

  //fonction pour la modification

  static Future<void> modifierUtilisateur(
      int id, Utilisateur utilisateur) async {
    final response = await http.put(
      Uri.parse('${apiUrl}user/update/$id'),
      headers: {"Content-Type": "application/json"},
      //body: jsonEncode(utilisateur.toJson())
    );

    if (response.statusCode == 200) {
      print('Utilisateur modifié avec succès');
    } else if (response.statusCode == 404) {
      print('Utilisateur non trouvé');
    } else {
      throw Exception(
          'Impossible de modifier l\'utilisateur : ${response.statusCode}');
    }
  }

  //fonction, pour la suppression
  static Future<void> supprimerUtilisateur(int id) async {
    final response = await http.delete(Uri.parse('${apiUrl}user/delete/$id'));

    if (response.statusCode == 200) {
      print('Utilisateur supprimé avec succès');
    } else if (response.statusCode == 404) {
      print('Utilisateur non trouvé');
    } else {
      throw Exception(
          'Impossible de supprimer l\'utilisateur : ${response.statusCode}');
    }
  }

  static String getPhotoUrl(int userId) {
    return '$apiUrl/photo/$userId';
  }
}
