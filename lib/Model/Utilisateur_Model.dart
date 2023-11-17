
class Utilisateur {
  final String nom;
  final String prenom;
  final String email;
  final String motdepasse;
  final String photo;

  const Utilisateur({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motdepasse,
    required this.photo,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      email: json['email'] as String,
      motdepasse: json['motdepasse'] as String,
      photo: json['photo'] as String,
    );
  }
}
