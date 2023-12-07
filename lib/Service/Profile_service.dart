import 'package:flutte_cuisine/Model/Ingredient_Model.dart';
import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/Service/Recette_service.dart';
import 'package:flutte_cuisine/pages/ajouterrecette.dart';
import 'package:flutte_cuisine/provider/util_provider.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ServicePro extends StatefulWidget {
  bool peutModifier;
  ServicePro({super.key, required Recette recette, required this.peutModifier});

  @override
  State<ServicePro> createState() => _ServiceProState();
}

Future<void> showRecipeDescriptionDialog(
    BuildContext context, bool editable, Recette recette) async {
  String description = recette.description!;
  String imageAsset = recette.photo;
  String recipeName = recette.nom!;
  List<Ingredient>? ingredientList = recette.ingredientList;
  VideoPlayerController controllerVideo =
      //kIsWeb
      //?
      VideoPlayerController.networkUrl(Uri.parse(apiVideoUrl + recette.video));
  //: VideoPlayerController.file(File(apiVideoUrl + recette.video));
  controllerVideo.initialize().then((_) {
    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  });
  var ing = ingredientList;
  print(apiVideoUrl + recette.video);
  return showDialog<void>(
    context: context,
    //barrierDismissible: true,
    builder: (BuildContext context) {
      var prixMoyen;
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
          // Utilisez SingleChildScrollView pour activer le défilement
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
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
                                'Ingrédients',
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
                                    Text(". ${ingredient.nom}",
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black)),
                                    Text(ingredient.prix,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ],
                                ),
                              FutureBuilder<double>(
                                future: additionnerPrix(ingredientList),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Text("Erreur de calcul");
                                  } else {
                                    double totalPrix = snapshot.data ?? 0.0;
                                    return Text(
                                      "Total des prix des condiments : ${totalPrix.toString()} Fcfa",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  controllerVideo.play();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return controllerVideo.value.isInitialized
                          ? Container(
                              height: 300,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: AspectRatio(
                                aspectRatio: controllerVideo.value.aspectRatio,
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onDoubleTap: () {
                                        if (controllerVideo.value.isPlaying) {
                                          controllerVideo.pause();
                                        } else {
                                          controllerVideo.play();
                                        }
                                      },
                                      child: VideoPlayer(controllerVideo),
                                    ),
                                    Positioned(
                                        top: 10,
                                        left: 10,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_back,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )),

                                    ClosedCaption(
                                        text:
                                            controllerVideo.value.caption.text,
                                        textStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                    // les buttons plays et pause
                                    Positioned(
                                        bottom: 50,
                                        right: 50,
                                        height: 50,
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                controllerVideo.value.isPlaying
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              onPressed: () {
                                                if (controllerVideo
                                                    .value.isPlaying) {
                                                  controllerVideo.pause();
                                                } else {
                                                  controllerVideo.play();
                                                }
                                              },
                                            )
                                          ],
                                        )),

                                    Positioned(
                                      //bottom: 0,
                                      child: VideoProgressIndicator(
                                          controllerVideo,
                                          allowScrubbing: true),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const CircularProgressIndicator();
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
                                    context
                                        .read<UtilProvider>()
                                        .setclientCurrentIndex(1);
                                    bool result =
                                        await RecetteService.supprimerRecette(
                                            recette.id!);
                                    print("je suis la");
                                    print(result);
                                    if (result) {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const Profil(),
                                      //     ));
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      context
                                          .read<UtilProvider>()
                                          .setclientCurrentIndex(3);

                                      // context
                                      //     .read<UtilProvider>()
                                      //     .setclientCurrentIndex(3);
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
                        width: 60 // Ajoutez de l'espace entre les boutons
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

// Future<double> calculerPrixMoyen(List<Ingredient> ingredients) async {
//   if (ingredients.isEmpty) {
//     return 0.0;
//   }

//   double totalPrix = 0.0;
//   for (var ingredient in ingredients) {
//     totalPrix += double.parse(ingredient.prix.toString());
//   }

//   return totalPrix / ingredients.length;
// }

Future<double> additionnerPrix(List<Ingredient> ingredients) async {
  double totalPrix = 0.0;
  for (var ingredient in ingredients) {
    totalPrix += double.parse(ingredient.prix.toString());
  }
  return totalPrix;
}

class _ServiceProState extends State<ServicePro> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
