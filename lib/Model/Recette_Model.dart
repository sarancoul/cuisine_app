import 'package:flutte_cuisine/Model/Ingredient_Model.dart';

class Recette {
  final int? id;
  final String nom;
  final String description;
  var photo;
  var video;
  List<Ingredient>? ingredientList;

  Recette(
      {this.id,
        this.ingredientList,
      required this.nom,
      required this.description,
      required this.photo,
      this.video});



  factory Recette.fromJson(Map<String, dynamic> json) {
    return Recette(
        id: json['id'],
        nom: json['nomrecette'],
        description: json['description'],
        photo: json['photo'] ??
            '', // Si 'photo' est null, utilisez une chaîne vide comme valeur par défaut
        video: json['videoData'] ??
            '', // Si 'videoData' est null, utilisez une chaîne vide comme valeur par défaut
        ingredientList: List<Ingredient>.from(
          json['ingredients']
                  .map((ingredient) => Ingredient.fromJson(ingredient)) ??
              [],
          //utilisateur Utilisateur.fromJson(json['utilisateur']);
        ));
  }
}
