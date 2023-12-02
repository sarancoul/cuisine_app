class Utilisateur {
  final int? id;
  final String? nom;
  final String? prenom;
  final String? email;
  final String? motdepasse;
  final String? photo;
  final bool? compteActif;

  const Utilisateur({
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.motdepasse,
    this.photo,
    this.compteActif,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      motdepasse: json['motdepasse'],
      photo: json['photo'],
      compteActif: json['compteActif'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'motdepasse': motdepasse,
      'photo': photo,
      'compteActif': compteActif ?? false,
    };
  }
}
