import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/pages/navigation.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Service extends StatefulWidget {
  final Recette recette;
  const Service({required this.recette, Key? key}) : super(key: key);

  String getDescription() {
    return recette.description;
  }

  @override
  State<Service> createState() => _ServiceState();
}

Future<void> showRecipeDescriptionDialog(
    BuildContext context,
    String description,
    String imageAsset,
    String recipeName,
    List ingredientList,
    {required Navigation Function(dynamic context) builder}) async {
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
                  Image.asset(imageAsset),
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
                child: const Row(
                  children: [
                    //partie gauche liste ingredients
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingrédients',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: secondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
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
              )
            ],
          ),
        ),
      );
    },
  );
}

class VideoPopup extends StatelessWidget {
  final String videoAssetPath;

  const VideoPopup({super.key, required this.videoAssetPath});

  @override
  Widget build(BuildContext context) {
    final VideoPlayerController controller =
        VideoPlayerController.asset(videoAssetPath);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AspectRatio(
            // affiche correcrement la video
            aspectRatio: 16 / 9,
            child: VideoPlayer(controller),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            child: const Text(
              'Fermer la vidéo',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
