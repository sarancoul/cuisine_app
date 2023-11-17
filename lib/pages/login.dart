import 'package:flutte_cuisine/Model/Utilisateur_Model.dart';
import 'package:flutte_cuisine/Service/UtilisateurService.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController motdepasse_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    email_controller.clear();
    motdepasse_controller.clear();
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
                    ),
                    Column(
                      children: [
                        const Text(
                          "Connexion",
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
                  controller: email_controller,
                  decoration: const InputDecoration(
                    hintText: 'Entrez votre email',
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
                  // controller: email_controller,
                  controller: motdepasse_controller,
                  decoration: const InputDecoration(
                    hintText: 'Mot de passe',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final email = email_controller.text;
                      final motdepasse = motdepasse_controller.text;

                      try {
                        //recuperation user
                        List<Utilisateur> usersenregistre =
                            await UtilisateurService.getAllUsers();
                        bool finduser = false;
                        Utilisateur utilisateurConnecte;
                        for (Utilisateur utilisateur in usersenregistre) {
                          if (utilisateur.email == email &&
                              utilisateur.motdepasse == motdepasse) {
                            finduser = true;
                            utilisateurConnecte = utilisateur;
                            break;
                          }
                        }
                        if (finduser) {
                          Navigator.pushReplacementNamed(context, '/Accueil');
                        } else {
                          String errorMessage =
                              'Connexion echouée. Verifier vos information de connexion .';
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
                        }
                      } catch (e) {
                        print(
                            'Erreur lors de la récupération de la liste des utilisateurs : $e');
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
                      'Connexion',
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