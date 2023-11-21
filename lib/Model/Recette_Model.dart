import 'package:flutte_cuisine/Model/Ingredient_Model.dart';

class Recette {
  int? id;
  final String nom;
  final String description;
  var photo;
  var video;
  List<Ingredient>? ingredientList;
  double points;

  Recette(
      {this.id,
      this.ingredientList,
      required this.nom,
      required this.description,
      required this.photo,
      this.points = 0,
      this.video});

  factory Recette.fromJson(Map<String, dynamic> json) {
    print(json['evaluationPoint']);
    return Recette(
        id: json['id'],
        nom: json['nomrecette'],
        description: json['description'],
        photo: json['photo'] ??
            '', 
        video: json['videoData'] ??
            '', 
        points: double.parse(json['evaluationPoint'].toString()),
        ingredientList: List<Ingredient>.from(
          json['ingredients']
                  .map((ingredient) => Ingredient.fromJson(ingredient)) ??
              [],
        
        ));
  }
}
