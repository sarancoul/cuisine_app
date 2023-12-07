import 'package:flutte_cuisine/Model/Ingredient_Model.dart';
import 'package:flutte_cuisine/Model/Utilisateur_Model.dart';

class Recette {
  int? id;
  final String? nom;
  final String? description;
  var photo;
  var video;
  List<Ingredient>? ingredientList;
  double points;
  DateTime? dateAjout;
  Utilisateur? utilisateur;

  Recette({
    this.id,
    this.ingredientList,
    this.nom,
    this.description,
    this.photo,
    this.points = 0,
    this.video,
    this.dateAjout,
    this.utilisateur,
  });

  factory Recette.fromJson(Map<String, dynamic> json) {
    print(json['evaluationPoint']);
    return Recette(
        id: json['id'],
        nom: json['nomrecette'],
        description: json['description'],
        photo: json['photo'] ?? '',
        video: json['videoData'] ?? '',
        points: double.parse(json['evaluationPoint'].toString()),
        dateAjout: DateTime.parse(json['dateAjout']),
        utilisateur: Utilisateur.fromJson(json['utilisateur']),
        ingredientList: List<Ingredient>.from(
          json['ingredients']
                  .map((ingredient) => Ingredient.fromJson(ingredient)) ??
              [],
        ));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomrecette': nom,
      'description': description,
      'photo': photo,
      'videoData': video,
      'evaluationPoint': points,
      'date_ajout': dateAjout?.toIso8601String(),
      //'ingredients': ingredientList.map((ingredient) => ingredient.toJson()).toList(),
    };
  }
}
