import 'package:flutte_cuisine/Model/Ingredient_Model.dart';
import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class RecetteDetailPage extends StatefulWidget {
  Recette? recette;
  RecetteDetailPage({super.key, required this.recette});

  @override
  State<RecetteDetailPage> createState() => _RecetteDetailPageState();
}

class _RecetteDetailPageState extends State<RecetteDetailPage> {
  @override
  Widget build(BuildContext context) {
    List<Ingredient> ingrediantList = widget.recette!.ingredientList!;
    Recette recette;
    VideoPlayerController controllerVideo = VideoPlayerController.networkUrl(
        Uri.parse(apiVideoUrl + (widget.recette?.video ?? "")));
    controllerVideo.initialize().then((_) {});

    return SingleChildScrollView(
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget.recette?.photo != null
              ? FadeInImage.assetNetwork(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.3,
                  placeholder: "assets/images/iconeImage.png",
                  image: apiImageUrl + widget.recette?.photo!,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/images/iconeImage.png");
                  },
                )
              : Image.asset("assets/images/zame.png"),
          Text(
            widget.recette!.nom!,
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
                'Description',
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
                  widget.recette!.description!,
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
                      const Text(
                        'Ingrédients',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor),
                      ),
                      Column(
                          children: ingrediantList.map((e) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.nom,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black)),
                            Text(e.prix,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black)),
                          ],
                        );
                      }).toList()),
                      FutureBuilder<double>(
                        future: calculerPrixMoyen(ingrediantList),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text("Erreur de calcul");
                          } else {
                            double prixMoyen = snapshot.data ?? 0.0;
                            return Text(
                              "Prix moyen des condiments : ${prixMoyen.toString()} Fcfa",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold),
                            );
                          }
                        },
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )),

                                ClosedCaption(
                                    text: controllerVideo.value.caption.text,
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
                                  child: VideoProgressIndicator(controllerVideo,
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
        ],
      ),
    );
  }

  Future<double> calculerPrixMoyen(List<Ingredient> ingredients) async {
    if (ingredients.isEmpty) {
      return 0.0;
    }

    double totalPrix = 0.0;
    for (var ingredient in ingredients) {
      totalPrix += double.parse(ingredient.prix.toString());
    }

    return totalPrix / ingredients.length;
  }
}
