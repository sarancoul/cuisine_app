import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String title = 'first page';
  String Supprimercompte = 'Supprimer compte';
  String Deconnexion = 'Deconnexion';
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
              const Text("@nameprofile"),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Text("180 plats"),
                  Text("180 Evaluations"),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 400,
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  scrollDirection: Axis.vertical,
                  children: [
                    //for (var i = 0; i < 1; i++) CardRecette(show: false),
                    Card(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 9,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // showRecipeDescriptionDialog(
                              //   context,
                              //   '',
                              //   'assets/images/zame.png',
                              //   'Zamin chèman',

                              // );
                            },
                            child: Image.asset("assets/images/zame.png"),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Zamin chèman",
                                  style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
