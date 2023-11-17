import 'dart:io';

import 'package:flutte_cuisine/Service/UtilisateurService.dart';
import 'package:flutte_cuisine/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _LoginPageState();

  //static Future<Inscription> fromJson(jsonDecode) {}
}

class _LoginPageState extends State<Inscription> {
  TextEditingController nom_controller = TextEditingController();
  TextEditingController prenom_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController motdepasse_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController photo_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    nom_controller.clear();
    prenom_controller.clear();
    email_controller.clear();
    motdepasse_controller.clear();
  }

  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // Afficher un signalement indiquant que la photo a été prise en compte
      const snackBar = SnackBar(
        content: Text('Photo prise en compte'),
        duration: Duration(seconds: 2),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/images/icone.png",
                height: 100,
                width: 200,
              ),
              Image.asset(
                "assets/images/zame.png",
                height: 200,
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Inscription",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Visibility(
                          visible: true,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            height: 5,
                            width: 90,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Connexion",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            height: 5,
                            width: 90,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: prenom_controller,
                  decoration: const InputDecoration(
                    hintText: 'Prénom',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: nom_controller,
                  decoration: const InputDecoration(
                    hintText: 'Nom',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: email_controller,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: motdepasse_controller,
                  decoration: const InputDecoration(
                    hintText: 'Mot de passe',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Row(
              //     children: [
              //       IconButton(
              //         onPressed: _pickImage,
              //         icon: const Icon(Icons.photo_library),
              //       ),
              //       Expanded(
              //         child: TextField(
              //           controller: photo_controller,
              //           decoration: const InputDecoration(
              //             hintText: 'Photo',
              //             border: InputBorder.none,
              //             contentPadding: EdgeInsets.all(5),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final nom = nom_controller.text;
                      final prenom = prenom_controller.text;
                      final email = email_controller.text;
                      final motdepasse = motdepasse_controller.text;
                      final photo = photo_controller.text;
                      const String errorMessage =
                          "champs vides non enregistrés";
                      if (nom.isEmpty &&
                          prenom.isEmpty &&
                          email.isEmpty &&
                          motdepasse.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(child: Text('Erreur')),
                              content: const Text(errorMessage),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }
                      try {
                        final newuser = await UtilisateurService.createUser(
                            nom: nom,
                            prenom: prenom,
                            email: email,
                            motdepasse: motdepasse,
                            photo: photo);
                        // ignore: use_build_context_synchronously

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                        // Navigator.pushReplacementNamed(context, '/LoginPage');
                      } catch (e) {
                        debugPrint(e.toString());
                        String errorMessage = 'Inscription réussie';
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(child: Text('Erreur')),
                              content: Text(errorMessage),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );

                        // nom_controller.clear();
                        // prenom_controller.clear();
                        // email_controller.clear();
                        // motdepasse_controller.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB72C2B),
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Inscription',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
