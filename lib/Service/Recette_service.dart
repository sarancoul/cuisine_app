import 'dart:convert';

import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:http/http.dart' as http;

class RecetteService {
  final String baseUrl;
  static const apiUrl = 'http://localhost:8081/recette';
  RecetteService(this.baseUrl);

  Future<List<Recette>> rechercherRecettesParNom(String nom) async {
    final response = await http.get(Uri.parse('$baseUrl/search/nom?nom=$nom'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Recette.fromJson(json)).toList();
    } else {
      throw Exception(
          'Erreur lors de la recherche de recettes : ${response.statusCode}');
    }
  }

  static Future<Recette> updateRecette({required Recette recette}) async {
    print("en cours dans le update${recette.id}");
    var id = recette.id;
    print("en cours dans le update${recette.ingredientList}");
    List jsonIngredientList = recette.ingredientList!
        .map((ingredient) => ingredient.toJson())
        .toList();
    final response = await http.put(Uri.parse('$apiUrl/update/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': recette.id,
          'nomrecette': recette.nom,
          'description': recette.description,
          'photo': recette.photo,
          'videoData': recette.video,
          'ingredients': jsonIngredientList,
          "utilisateur": {
            "id": 1,
            "nom": "coulibaly",
            "prenom": "Saran",
            "email": "sc523644@gmail.com",
            "motdepasse": "445566",
            "photo": "profil.png",
          },
        }));
    print("voici la response");
    if (response.statusCode == 201 || response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Recette.fromJson(json);
    } else {
      throw Exception('Utilisateur non ajouter : ${response.statusCode}');
    }
  }

  static Future<bool> supprimerRecette(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/delete/$id'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      print('Recette supprimé avec succès');
      return true;
    } else if (response.statusCode == 404) {
      return false;
      print('Recette non trouvé');
    } else {
      throw Exception(
          'Impossible de supprimer la recette : ${response.statusCode}');
    }
  }
}
