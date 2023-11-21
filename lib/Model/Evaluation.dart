class Evaluation {
  int recetteId;
  double rating;

  Evaluation({required this.recetteId, required this.rating});

  Map<String, dynamic> toJson() {
    return {
      'recette': {'id': recetteId},
      'point': rating,
    };
  }
}
