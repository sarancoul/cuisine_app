import 'package:flutte_cuisine/Model/Ingredient_Model.dart';
import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/Service/Recette_service.dart';
import 'package:flutte_cuisine/Service/mes_service.dart';
import 'package:flutte_cuisine/pages/ajouterrecette.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';

class ServicePro extends StatefulWidget {
  bool peutModifier;
  ServicePro({super.key, required Recette recette, required this.peutModifier});

  @override
  State<ServicePro> createState() => _ServiceProState();
}

Future<void> showRecipeDescriptionDialog(
    BuildContext context, bool editable, Recette recette) async {
  String description = recette.description;
  String imageAsset = recette.photo;
  String recipeName = recette.nom;
  List<Ingredient>? ingredientList = recette.ingredientList;

  var ing = ingredientList;
  print(ingredientList);
  return showDialog<void>(
    context: context,
    //barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
          // Utilisez SingleChildScrollView pour activer le défilement
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: secondaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Stack(
                alignment:
                    Alignment.topRight, // Pour placer l'icône en haut à droite
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: imageAsset != null
                        ? FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: 300,
                            placeholder: "assets/images/iconeImage.png",
                            image: apiImageUrl + imageAsset,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  "assets/images/iconeImage.png");
                            },
                          )
                        : Image.asset("assets/images/zame.png"),
                  )
                ],
              ),
              Text(
                recipeName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    'Descriptions',
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: secondaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: secondaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    //partie gauche liste ingredients
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ingédients',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor),
                              ),
                              Text('Prix',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: secondaryColor)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var ingredient in ingredientList!)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(ingredient.nom,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    Text(ingredient.prix,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const VideoPopup(
                        videoAssetPath:
                            'https://youtu.be/UGsvfsrP2fo?si=Ni8al1CmtLPWJNGd',
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: const Text(
                  'Voir la vidéo',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Visibility(
                visible: editable,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmation de suppression'),
                              content:
                                  const Text('Voulez-vous vraiment supprimer?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Non'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Oui'),
                                  onPressed: () async {
                                    bool result =
                                        await RecetteService.supprimerRecette(
                                            recette.id!);
                                    if (result) {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Supprimé avec succès'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                      ),
                      child: const Text(
                        'Supprimer',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 150.0, // Ajoutez de l'espace entre les boutons
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AjouterRecette(
                                  recette: recette,
                                ),
                              ));
                        },
                        child: const Text(
                          'Modifier',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _ServiceProState extends State<ServicePro> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
