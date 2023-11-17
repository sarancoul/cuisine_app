import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/Service/Profile_service.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CardRecette extends StatefulWidget {
  Recette recette;
  CardRecette({super.key, this.show = false, required this.recette});
  bool show;
  @override
  State<CardRecette> createState() => _CardRecetteState();
}

class _CardRecetteState extends State<CardRecette> {
  @override
  Widget build(BuildContext context) {
    var myrecette = widget.recette;

    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      elevation: 10,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              showRecipeDescriptionDialog(context, myrecette);
            },
            child: myrecette.photo != null
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: 300,
                    placeholder: "assets/images/iconeImage.png",
                    image: apiImageUrl + myrecette.photo,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/images/iconeImage.png");
                    },
                  )
                : Image.asset("assets/images/zame.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.recette.nom,
                  style: const TextStyle(
                      color: secondaryColor, fontWeight: FontWeight.bold),
                ),
                Visibility(
                  visible: widget.show,
                  child: const Icon(
                    Icons.message,
                    color: primaryColor,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
            child: Visibility(
              visible: widget.show,
              child: RatingBar(
                itemSize: 30,
                initialRating: 3,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    size: 2,
                    color: primaryColor,
                  ),
                  half: const Icon(
                    size: 2,
                    Icons.star,
                    color: Colors.white,
                  ),
                  empty: const Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  setState(() {});
                },
                updateOnDrag: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
