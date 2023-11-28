import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/Service/HtppUploadFileService.dart';
import 'package:flutte_cuisine/Service/UtilisateurService.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutte_cuisine/widgets/cart_recette.dart';
import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late final String utilisateur;
  // late int dishCount;
  String title = 'first page';
  String Supprimercompte = 'Supprimer compte';
  String Deconnexion = 'Deconnexion';
  late Future<List<Recette>> futurerecettes;
  late Future<int> dishCount;
  TextEditingController photo_controller = TextEditingController();

  String? utilisateurInscrit;
  int? utilisateurId;
  @override
  void initState() {
    super.initState();
    futurerecettes = HttpUploadService().fetchRecettes();
    dishCount = HttpUploadService.getNombreTotalRecettes();
    if (utilisateurId != null) {
      var user = UtilisateurService.getPhotoUrl(utilisateurId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: (Supprimercompte),
                child: Text(Supprimercompte),
              ),
              PopupMenuItem(
                value: (Deconnexion),
                child: Text(Deconnexion),
              )
            ],
            onSelected: (String newValue) {
              setState(() {
                title = newValue;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: primaryColor),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/01/06/16/14/woman-590490_1280.jpg'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 4, color: Colors.white),
                        color: secondaryColor,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '@$utilisateurInscrit',
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  FutureBuilder(
                    future: dishCount,
                    builder: (context, snapshot) {
                      // print(snapshot.data.)
                      int? val = snapshot.data;
                      return Text(
                        '$val recettes',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: secondaryColor),
                      );
                    },
                  ),
                  // const Text("180 Evaluations"),
                ],
              ),
              // Appel à la méthode buildRecetteGrid
              FutureBuilder<List<Recette>>(
                future: futurerecettes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Erreur de chargement des recettes');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Aucune recette disponible');
                  } else {
                    List<Recette> recettes = snapshot.data!;
                    return GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      childAspectRatio: 1 / 1.3,
                      children: [
                        for (var recette in recettes)
                          CardRecette(
                              show: true, editable: true, recette: recette),
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // Déplacement de la méthode buildRecetteGrid en dehors de la méthode build
  Widget buildRecetteGrid() {
    return FutureBuilder<List<Recette>>(
      future: futurerecettes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Erreur de chargement des recettes');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Aucune recette disponible');
        } else {
          List<Recette> recettes = snapshot.data!;
          return GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 1 / 1.3,
            children: [
              for (var recette in recettes)
                CardRecette(show: true, editable: true, recette: recette),
            ],
          );
        }
      },
    );
  }
}
