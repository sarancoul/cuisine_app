import 'dart:convert';
import 'dart:typed_data';

import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:http/http.dart' as http;

class HttpUploadService {
  static Future<void> addAddRecette({required Recette recette}) async {
    String addimageUrl = 'http://localhost:8081/recette/upload';
    var request = http.MultipartRequest('POST', Uri.parse(addimageUrl));
    List jsonIngredientList = recette.ingredientList!
        .map((ingredient) => ingredient.toJson())
        .toList();
    print("jsonList: $jsonIngredientList");
    print("check si la photo n'est pas null");
    if (recette.photo != null) {
      Uint8List data = await recette.photo.readAsBytes();
      List<int> list = data.cast();
      request.files
          .add(http.MultipartFile.fromBytes('file', list, filename: "my.jpg"));
    }
    print("check si la video n'est pas null");
    if (recette.video != null) {
      Uint8List data = await recette.video.readAsBytes();
      List<int> list = data.cast();
      request.files
          .add(http.MultipartFile.fromBytes('video', list, filename: "my.mp4"));
    }
    request.fields['recette'] = jsonEncode({
      'nomrecette': recette.nom,
      'description': recette.description,
      'photo': "",
      'videoData': "",
      'ingredients': jsonIngredientList,
      "utilisateur": {
        "id": 1,
        "nom": "coulibaly",
        "prenom": "Saran",
        "email": "sc523644@gmail.com",
        "motdepasse": "445566",
        "photo": "profil.png",
      },
    });
    var response = await request.send();
    if (response.statusCode == 201) {
      print("donnée envoyé");
    } else {
      print("Donnée non envoyé");
    }
  }

  Future<List<Recette>> fetchRecettes() async {
    String baseUrl = 'http://localhost:8081/recette';
    String getRecetteUrl = '$baseUrl/all';

    try {
      final response = await http.get(Uri.parse(getRecetteUrl));
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        print("j'seuis la");
        try {
          List<Recette> recettes =
              jsonData.map((data) => Recette.fromJson(data)).toList();
        } catch (e) {
          print(e.toString());
        }

        print("200");
        return jsonData.map((data) => Recette.fromJson(data)).toList();
      } else {
        throw Exception(
            'Erreur lors de la récupération des recettes: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération des recettes: $error');
    }
  }

static Future<void> supprimerRecette(int id) async {
  if (id == null) {
    throw Exception('L\'identifiant de la recette est invalide.');
  }

  const String baseUrl = 'http://localhost:8081/recette/delete';
  final String deleteRecetteUrl = '$baseUrl/$id';

  try {
    final response = await http.delete(Uri.parse(deleteRecetteUrl));

    if (response.statusCode == 200) {
      print('Recette supprimée avec succès.');
    } else {
      print('Erreur lors de la suppression de la recette: ${response.statusCode}');
    }
  } catch (error) {
    print('Erreur lors de la suppression de la recette: $error');
  }
}
}
