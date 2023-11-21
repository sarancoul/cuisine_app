import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/Service/HtppUploadFileService.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutte_cuisine/widgets/cart_recette.dart';
import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final TextEditingController _nomcontroller = TextEditingController();
  late Future<List<Recette>> futurerecettes;

  @override
  void initState() {
    super.initState();
    futurerecettes = HttpUploadService().fetchRecettes();
    //ServicePro(peutModifier: false,);
  }

  Future<void> _searchRecettes(String search) async {
    try {
      setState(() {
        futurerecettes = HttpUploadService().searchRecipes(search);
      });
    } catch (e) {
      print('Erreur lors de la recherche de recettes : $e');
    }
  }

  Future<void> _showRecettes() async {
    try {
      setState(() {
        futurerecettes = HttpUploadService().fetchRecettes();
      });
    } catch (e) {
      print('Erreur lors de la recherche de recettes : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              buildHeader(),
              buildRecetteGrid(),
              //buildPlaceholderRecette(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 90,
      title: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _nomcontroller,
                onChanged: (text) =>
                    text == "" ? _showRecettes() : _searchRecettes(text),
                decoration: InputDecoration(
                  hintText: "Rechercher une recette...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(
                      Icons.search,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      height: 200,
      child: Image.asset("assets/images/O-Fanta_en_cuisine.gif"),
    );
  }

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
                CardRecette(show: true, editable: false, recette: recette),
            ],
          );
        }
      },
    );
  }

  Widget buildPlaceholderRecette() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        scrollDirection: Axis.vertical,
        children: const [],
      ),
    );
  }
}
