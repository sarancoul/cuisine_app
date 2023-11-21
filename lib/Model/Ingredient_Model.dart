class Ingredient {
  int? id;
  final String nom;
  final String prix;

  Ingredient({this.id,required this.nom, required this.prix});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(id:json["id"], nom: json["nom"], prix: json["prix"].toString());
  }
  Map<String, dynamic> toJson() {
    return {"id":id, "nom": nom, "prix": prix};
  }
}
