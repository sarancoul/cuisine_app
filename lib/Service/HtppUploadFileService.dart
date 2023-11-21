import 'dart:convert';
import 'dart:typed_data';

import 'package:flutte_cuisine/Model/Evaluation.dart';
import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/pages/navigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpUploadService {
  static Future<bool> updateVideo({required videoName, var video}) async {
    String addimageUrl = 'http://localhost:8081/recette/updateVideo';
    var request = http.MultipartRequest('POST', Uri.parse(addimageUrl));
    print("check si la video n'est pas null");
    if (video != null) {
      Uint8List data = await video.readAsBytes();
      List<int> list = data.cast();
      request.files.add(
          http.MultipartFile.fromBytes('video', list, filename: videoName));
    }
    var response = await request.send();
    if (response.statusCode == 201) {
      print("la video a été updater envoyé");
      return true;
    } else {
      print("Donnée non updater");
      return false;
    }
  }
  /////////////////////###############################////////////////////////////////////////

  static Future<bool> updateImage(
      {required String photoName, var image}) async {
    String addimageUrl = 'http://localhost:8081/recette/updatePhoto';
    var request = http.MultipartRequest('POST', Uri.parse(addimageUrl));
    print("check si la photo n'est pas null");
    if (image != null) {
      Uint8List data = await image.readAsBytes();
      List<int> list = data.cast();
      request.files
          .add(http.MultipartFile.fromBytes('file', list, filename: photoName));
    }
    var response = await request.send();
    if (response.statusCode == 201) {
      print("l'image a été updater");
      return true;
    } else {
      print("Image non updater");
      return false;
    }
  }
  ////////////////////////////#########################################/////////////////////////////////////////////

  static Future<void> addAddRecette(
      {required BuildContext context, required Recette recette}) async {
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
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Navigation(),
          ));
    } else {
      print("Donnée non envoyé");
    }
  }

///////////////////////////////###############################//////////////////////////////////////
  Future<List<Recette>> fetchRecettes() async {
    String baseUrl = 'http://localhost:8081/recette';
    String getRecetteUrl = '$baseUrl/all';

    try {
      print(Uri.parse(getRecetteUrl));
      final response = await http.get(Uri.parse(getRecetteUrl));
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        // print("j'seuis la");
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

///////////////////////////#####################//////////////////////////////////////////////////
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
        print(
            'Erreur lors de la suppression de la recette: ${response.statusCode}');
      }
    } catch (error) {
      print('Erreur lors de la suppression de la recette: $error');
    }
  }

//////////////////////////////////######################################################//////////////////////////////////////////////
  Future<List<Recette>> rechercher(String nom) async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8081/recette/search/nom?nom=$nom'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse =
            json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse.map((data) => Recette.fromJson(data)).toList();
      } else {
        throw Exception(
            'Erreur de chargement des recettes. Code HTTP ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la recherche de recettes : $e');
      rethrow; // Rethrow pour propager l'erreur
    }
  }

  //////////////////////////////////send la valeurs des rating bar##############################///////////////////////////////////////////////////

  static Future<void> sendRating(double rating, Recette myrecette) async {
    print(rating);
    print(myrecette);
    try {
      if (myrecette.id == null) {
        print('Erreur : myrecette ou son ID est null.');
        return;
      }

      int recetteId = myrecette.id!;
      Evaluation evaluation = Evaluation(recetteId: recetteId, rating: rating);
      print(evaluation.toJson());

      var response = await http.post(
        Uri.parse('http://localhost:8081/recette/createEva'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': 'http://localhost:8081',
        },
        body: jsonEncode(evaluation.toJson()),
      );

      if (response.statusCode == 201) {
        print('Évaluation enregistrée avec succès');
      } else {
        print(
            'Échec de l\'enregistrement de l\'évaluation. Statut : ${response.statusCode}');
      }
    } catch (error) {
      print('Erreur lors de l\'enregistrement de l\'évaluation : $error');
    }
  }

  ///////////////////////###########################AVOIR LE TOTAL DES RECETTES /////////////////////////////////////

  static Future<int> getNombreTotalRecettes() async {
    print("Le nombre de recette =>INII");
    final response = await http.get(
      Uri.parse(
          'http://localhost:8081/recette/nombreTotalRecettes?utilisateurId=1'),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      int jsonResponse = json.decode(response.body);
      print("voici le nombre total$jsonResponse");
      return jsonResponse;
      //return jsonResponse['nombreTotalRecettes'];
    } else {
      print("Le nombre de recette => ERROR");
      throw Exception('Échec de la récupération du nombre total de recettes');
    }
  }
  //////////////////////////////###########Fonction recherche par ingredient###########/////////////////////

  Future<List<Recette>> searchRecipes(String ingredientNames) async {
    const String apiUrl = 'http://localhost:8081/recette/chercher';
    //List<String> ingredientNames = ingredientNames.
    String queryParams = '?ingredientNames=""&ingredientNames=';
    String ings = ingredientNames.trim().split(" ").join("&ingredientNames=");
    queryParams = queryParams + ings;
    print(ings);
    // for(int i = 0; i < ings.length; i++){
    //         queryParams.join("nom like '%").append(names.get(i)).append("%'");
    //         if(i != size-1){
    //             query.append(" OR ");
    //         }
    //     }
    try {
      // final String queryParams = 'ingredientNames=$ingredientNames';

      print(Uri.parse('$apiUrl$queryParams'));

      final response = await http.get(Uri.parse('$apiUrl?$queryParams'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Recette> recettes =
            data.map((item) => Recette.fromJson(item)).toList();
        return recettes;
      } else {
        print('Erreur de requête : ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Erreur : $e');
      return [];
    }
  }
}
