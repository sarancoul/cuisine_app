import 'package:another_flushbar/flushbar.dart';
import 'package:flutte_cuisine/Dashbord/serviceDashbord.dart';
import 'package:flutte_cuisine/Model/Utilisateur_Model.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _controller = TextEditingController();
  List<Utilisateur> rechercheusers = [];
  List<Utilisateur> utilisateurs = [];

  @override
  void initState() {
    super.initState();
    recupererUsers();
    //setState(() {});
  }

  Future<void> recupererUsers() async {
    try {
      List<Utilisateur> users = await dashbordService().getAllUsers();
      setState(() {
        utilisateurs = users;
      });
    } catch (e) {
      print('Erreur lors du chargement des utilisateurs : $e');
    }
  }

  void recherche() async {
    final String nom = _controller.text.trim();
    if (nom.isNotEmpty) {
      try {
        List<Utilisateur> results =
            await dashbordService.searchUsersByName(nom);
        setState(() {
          rechercheusers = results;
        });
      } catch (e) {
        print('Erreur lors de la recherche : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Color.fromARGB(255, 140, 121, 65),
                    backgroundImage: AssetImage("assets/images/mage2.png"),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Image.asset(
                      "assets/images/icone.png",
                      height: 84.0,
                      width: 84.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(fontSize: 12.0),
                      decoration: const InputDecoration(
                        hintText: 'Recherche',
                        contentPadding: EdgeInsets.all(
                            10.0), // Ajustez le rembourrage interne
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: DataTable(
                columnSpacing: 30,
                decoration: const BoxDecoration(),
                columns: const [
                  DataColumn(
                      label: Text(
                    "Photo",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    "Nom",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    "Prénom",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    "Email",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    "Status",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ],
                rows: utilisateurs.map(
                  (e) {
                    return dataRow(e);
                  },
                ).toList(),
              ),
            ),
            Container(
              child: const Column(children: []),
            )
          ],
        ),
      ),
    );
  }

  DataRow dataRow(Utilisateur utilisateur) {
    return DataRow(cells: [
      const DataCell(Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 30.0,
          backgroundColor: Color.fromARGB(255, 140, 121, 65),
          backgroundImage: AssetImage("assets/images/mage2.png"),
        ),
      )),
      DataCell(Text(utilisateur.prenom!)),
      DataCell(Text(utilisateur.nom!)),
      DataCell(Text(utilisateur.email!)),
      DataCell(Row(
        children: [
          InkWell(
            onTap: () async {
              await dashbordService.activerCompte(utilisateur.id!);
              Flushbar(
                message: 'Compte Activé avec succès',
                duration: const Duration(seconds: 2),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: primaryColor,
              ).show(context);
            },
            child: const Icon(
              Icons.check,
              color: primaryColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () async {
              await dashbordService.desactiverCompte(utilisateur.id!);
              Flushbar(
                message: 'Compte désactivé avec succès',
                duration: const Duration(seconds: 2),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: secondaryColor,
              ).show(context);
            },
            child: const Icon(
              Icons.block,
              color: secondaryColor,
            ),
          ),
        ],
      ))
    ]);
  }
}
