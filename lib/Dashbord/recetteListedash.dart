import 'package:flutte_cuisine/Dashbord/ajouterrecette.dart';
import 'package:flutte_cuisine/Dashbord/recette_details_page.dart';
import 'package:flutte_cuisine/Dashbord/serviceDashbord.dart';
import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/Model/Utilisateur_Model.dart';
import 'package:flutte_cuisine/Service/HtppUploadFileService.dart';
import 'package:flutte_cuisine/Service/Recette_service.dart';
import 'package:flutte_cuisine/provider/util_provider.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RecetteAjout extends StatefulWidget {
  const RecetteAjout({super.key});

  @override
  State<RecetteAjout> createState() => _RecetteAjoutState();
}

class _RecetteAjoutState extends State<RecetteAjout> {
  List<Recette> recettes = [];
  Recette? recette;
  List<Utilisateur> utilisateurs = [];
  Utilisateur? utilisateur;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showRecettes();
    print("voici la taille niveau ");
    print(recettes.length);
    showUtilisateurs();
  }

  void showRecettes() async {
    recettes = await HttpUploadService.fetchAllRecettes();
    print("voici la taille niveau 2");
    setState(() {});
    print(recettes.length);
  }

  void showUtilisateurs() async {
    utilisateurs = await dashbordService().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    print("voici la taille");
    print(recettes.length);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: Column(children: [
                //header
                Container(
                  margin: const EdgeInsets.all(12),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .115,
                        padding: const EdgeInsets.only(left: 30),
                        child: const Text(
                          'Recette',
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .25,
                        padding: const EdgeInsets.only(left: 50),
                        child: const Text(
                          'Utilisateurs',
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.only(left: 50),
                      //   child: const Text(
                      //     '',
                      //     style: TextStyle(
                      //       color: secondaryColor,
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        width: 120,
                        child: Text(
                          'Actions',
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //body
                Container(
                  padding: const EdgeInsets.all(10),
                  //height: 300,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 235, 226, 226),
                      border: Border.all(width: 1, color: secondaryColor)),
                  child: Column(
                    children: recettes.map((e) {
                      return recetteListItem(e);
                    }).toList(),
                  ),
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width * .3,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 225, 225),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: recette != null
                    ? RecetteDetailPage(
                        recette: recette,
                      )
                    : Container(),
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell recetteListItem(Recette rec) {
    return InkWell(
      onTap: () {
        recette = rec;
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                backgroundImage: rec.photo != null
                    ? FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.3,
                        placeholder: "assets/images/iconeImage.png",
                        image: apiImageUrl + rec.photo,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/images/iconeImage.png");
                        },
                      ).image
                    : Image.asset("assets/images/zame.png").image,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  rec.nom!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: Text(
                "${rec.utilisateur!.nom!} ${rec.utilisateur!.prenom!}",
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.read<UtilProvider>().setRecette(rec);
                      context.read<UtilProvider>().setdashboardCurrentIndex(
                          UtilProvider().getIndex(AjouterRecetteDash));
                    },
                    child: const Icon(
                      FontAwesomeIcons.penToSquare,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
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
                                    bool result =
                                        await RecetteService.supprimerRecette(
                                            rec.id!);
                                    if (result) {
                                      print("je vais remover");
                                      recettes.removeAt(recettes.indexOf(rec));
                                      setState(() {});
                                      //
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Icon(
                        FontAwesomeIcons.trash,
                        color: secondaryColor,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   print("voici la taille");
  //   print(recettes.length);
  //   return Scaffold(
  //     backgroundColor: Colors.grey,
  //     body: SizedBox(
  //       width: MediaQuery.of(context).size.width,
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Column(children: [
  //               //header
  //               Container(
  //                 // width: 500,
  //                 margin: const EdgeInsets.all(12),
  //                 child: DataTable(
  //                     columnSpacing: 30,
  //                     decoration: const BoxDecoration(),
  //                     columns: const [
  //                       DataColumn(
  //                         label: Text(
  //                           "Photo",
  //                           style: TextStyle(
  //                             color: secondaryColor,
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                       DataColumn(
  //                         label: Text(
  //                           "Nom",
  //                           style: TextStyle(
  //                             color: secondaryColor,
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                       DataColumn(
  //                         label: Text(
  //                           "Descriptions",
  //                           style: TextStyle(
  //                             color: secondaryColor,
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                       DataColumn(
  //                         label: Text(
  //                           "Actions",
  //                           style: TextStyle(
  //                             color: secondaryColor,
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                     rows:
  //                         //recettes.map((rec) => dataRow(rec)).toList(),

  //                         // for (Recette rec in recettes)
  //                         recettes.map((e) {
  //                       return const DataRow(cells: [
  //                         DataCell(Text("dfs")),
  //                         DataCell(Text("dfs")),
  //                         DataCell(Text("dfs")),
  //                         DataCell(Text("dfs"))
  //                       ]);
  //                     }).toList()),
  //               ),
  //             ]),
  //           ),
  //           Container(
  //             margin: const EdgeInsets.all(12),
  //             width: MediaQuery.of(context).size.width * .3,
  //             decoration: BoxDecoration(
  //               color: const Color.fromARGB(255, 235, 225, 225),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(13),
  //               child: recette != null
  //                   ? RecetteDetailPage(
  //                       recette: recette,
  //                     )
  //                   : Container(),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // DataRow dataRow(Recette recette) {
  //   return DataRow(cells: [
  //     DataCell(
  //       SizedBox(
  //         width: 30,
  //         child: CircleAvatar(
  //           radius: 30.0,
  //           backgroundColor: Colors.white,
  //           backgroundImage: recette.photo != null
  //               ? FadeInImage.assetNetwork(
  //                   width: double.infinity,
  //                   height: MediaQuery.of(context).size.width * 0.3,
  //                   placeholder: "assets/images/iconeImage.png",
  //                   image: apiImageUrl + recette.photo,
  //                   imageErrorBuilder: (context, error, stackTrace) {
  //                     return Image.asset("assets/images/iconeImage.png");
  //                   },
  //                 ).image
  //               : Image.asset("assets/images/zame.png").image,
  //         ),
  //       ),
  //     ),
  //     DataCell(Text(recette.nom!)),
  //     DataCell(SizedBox(
  //       width: 300,
  //       child: Text(
  //         recette.description!,
  //         style: const TextStyle(
  //           overflow: TextOverflow.ellipsis,
  //           color: Colors.black,
  //           fontSize: 20,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     )),
  //     DataCell(
  //       SizedBox(
  //         width: 80,
  //         child: Row(
  //           children: [
  //             InkWell(
  //               onTap: () {
  //                 context.read<UtilProvider>().setRecette(recette);
  //                 context.read<UtilProvider>().setdashboardCurrentIndex(
  //                     UtilProvider().getIndex(AjouterRecetteDash));
  //               },
  //               child: const Icon(
  //                 FontAwesomeIcons.penToSquare,
  //                 color: primaryColor,
  //               ),
  //             ),
  //             const SizedBox(
  //               width: 5,
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 showDialog(
  //                   context: context,
  //                   builder: (BuildContext context) {
  //                     return AlertDialog(
  //                       title: const Text('Confirmation de suppression'),
  //                       content: const Text('Voulez-vous vraiment supprimer?'),
  //                       actions: <Widget>[
  //                         TextButton(
  //                           child: const Text('Non'),
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                           },
  //                         ),
  //                         TextButton(
  //                           child: const Text('Oui'),
  //                           onPressed: () async {
  //                             bool result =
  //                                 await RecetteService.supprimerRecette(
  //                                     recette.id!);
  //                             if (result) {
  //                               print("je vais remover");
  //                               recettes.removeAt(recettes.indexOf(recette));
  //                               setState(() {});
  //                               //
  //                               Navigator.of(context).pop();
  //                             }
  //                           },
  //                         ),
  //                       ],
  //                     );
  //                   },
  //                 );
  //               },
  //               child: const Icon(
  //                 FontAwesomeIcons.trash,
  //                 color: secondaryColor,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ]);
  // }
}
