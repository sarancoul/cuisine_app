import 'package:flutte_cuisine/Dashbord/widgets/dynamic_wiget.dart';
import 'package:flutte_cuisine/Model/Ingredient_Model.dart';
import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/Service/HtppUploadFileService.dart';
import 'package:flutte_cuisine/Service/Recette_service.dart';
import 'package:flutte_cuisine/provider/util_provider.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AjouterRecetteSecondePage extends StatefulWidget {
  Recette recette;
  AjouterRecetteSecondePage({super.key, required this.recette});

  @override
  State<AjouterRecetteSecondePage> createState() =>
      _AjouterRecetteSecondePageState();
}

class _AjouterRecetteSecondePageState extends State<AjouterRecetteSecondePage> {
  //final HttpUploadService _httpUploadService = HttpUploadService();
  bool waiting = false;

  //@override
  // ignore: must_call_super

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   ingredients.add(ajouterIngredient(1));
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.recette.ingredientList);
    if (widget.recette.ingredientList != null) {
      ingrediantList = widget.recette.ingredientList!;
      setIngredient();
      // setIngredient(widget.recette.ingredientList)
      //getIngredientData();
    }
    if (ingredients.isEmpty) {
      ingredients.add(DynamicWidgetIngredient(index: 0));
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  "assets/images/icone.png",
                  height: 50,
                  width: 200,
                ),
                const Text(
                  "Ajouter d'ingrédients",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  //height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.height * 0.9,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: secondaryColor),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Ingredient",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: secondaryColor),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                          const Text(
                            "Prix",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: secondaryColor),
                          ),
                        ],
                      ),
                      Container(
                        // width: 400,
                        // padding: const EdgeInsets.all(100),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 243, 243),
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: ingredients.length,
                            itemBuilder: (_, index) => ingredients[index]),
                      ),
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(10),
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor,
                                  padding: const EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Retour',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              )),
                          Container(
                              margin: const EdgeInsets.all(10),
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    ingredients.add(DynamicWidgetIngredient(
                                        index: ingredients.length));
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  padding: const EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: waiting
                                    ? const CircularProgressIndicator(
                                        color: secondaryColor,
                                      )
                                    : const Text(
                                        'Ajouter',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        waiting = true;
                      });
                      debugPrint(widget.recette.description.toString());
                      print("je vais initier l'envoi");
                      widget.recette.ingredientList = getIngredientData();
                      print("L'id de la recette =>${widget.recette.id}");
                      //ImageService.uploadFile(widget.recette.photo);
                      print("Envoi de la recette");
                      if (widget.recette.id != null) {
                        print("je vais updater la recette");
                        RecetteService.updateRecette(recette: widget.recette);
                        Navigator.pop(context);
                      } else {
                        await HttpUploadService.addAddRecette(
                            context: context,
                            recette: widget.recette,
                            utilisateur:
                                context.read<UtilProvider>().utilisateur);
                      }
                      Navigator.pop(context);
                      context.read<UtilProvider>().setclientCurrentIndex(3);

                      //Navigator.pushReplacementNamed(context, '/Profil');
                      //setState(() {});
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const Accueil(),
                      //     ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Enrégistrer',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Ingredient> getIngredientData() {
    ingrediantList = [];
    for (var mwidget in ingredients) {
      debugPrint(mwidget.ingredientId.toString());
      debugPrint("voici le prix => ${mwidget.prixController.text}");
      debugPrint("voici l'ingr => ${mwidget.ingreController.text}");

      ingrediantList.add(Ingredient(
          id: mwidget.ingredientId,
          nom: mwidget.ingreController.text,
          prix: mwidget.prixController.text));
    }
    // setState(() {});

    print("terminé");
    return ingrediantList;
    // print(data.length);
  }

  setIngredient() {
    print("le setter ingredient$ingrediantList");
    ingredients = [];
    for (var i = 0; i < ingrediantList.length; i++) {
      DynamicWidgetIngredient d = DynamicWidgetIngredient(index: i);
      d.ingredientId = ingrediantList[i].id;
      d.ingreController.text = ingrediantList[i].nom;
      d.prixController.text = ingrediantList[i].prix;
      ingredients.add(d);
    }
    widget.recette.ingredientList = null;
    setState(() {});
  }

  // Dismissible ajouterIngredient(int index) {
  //   TextEditingController ingreController = TextEditingController();
  //   TextEditingController prixController = TextEditingController();
  //   return Dismissible(
  //     key: GlobalKey(),
  //     direction: ingredients.isNotEmpty
  //         ? DismissDirection.startToEnd
  //         : DismissDirection.none,
  //     onDismissed: (direction) {
  //       setState(() {
  //         ingredients.removeAt(index);
  //       });
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //         width: MediaQuery.of(context).size.width * 0.8,
  //         // height: 100,
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
  //         child: Row(
  //           children: [
  //             const Icon(Icons.drag_indicator),
  //             Expanded(
  //               child: Container(
  //                 margin: const EdgeInsets.symmetric(horizontal: 5),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.grey),
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 child: TextField(
  //                   controller: ingreController,
  //                   decoration: const InputDecoration(
  //                     hintText: 'Ingrédient',
  //                     border: InputBorder.none,
  //                     contentPadding: EdgeInsets.all(10),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 margin: const EdgeInsets.symmetric(horizontal: 5),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.grey),
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 child: TextField(
  //                   controller: prixController,
  //                   decoration: const InputDecoration(
  //                     hintText: 'Prix',
  //                     border: InputBorder.none,
  //                     contentPadding: EdgeInsets.all(10),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             // Expanded(child: TextFormField()),
  //             //Expanded(child: TextFormField())
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
