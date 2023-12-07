import 'package:flutte_cuisine/Dashbord/serviceDashbord.dart';
import 'package:flutte_cuisine/Model/Ingredient_Model.dart';
import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/Service/HtppUploadFileService.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccueilDashboard extends StatefulWidget {
  const AccueilDashboard({Key? key}) : super(key: key);

  @override
  State<AccueilDashboard> createState() => _AccueilDashboardState();
}

class _AccueilDashboardState extends State<AccueilDashboard> {
  late Future<List<Recette>> futurerecettes;
  late Future<int> dishCount;
  late Future<int> recetteAdmin;

  int? utilisateurId;
  final dashbordService _service = dashbordService();
  late Future<int> utilisateurs;
  List<Recette> recettes = [];

  @override
  void initState() {
    super.initState();
    futurerecettes = HttpUploadService().fetchRecettes();
    dishCount = HttpUploadService.getNombreTotalRecettes();
    recetteAdmin = dashbordService.getNombreTotalRecettesAdmin();
    utilisateurs = dashbordService.getNombreTotalUser();
    initializeRecettes();
  }

  Future<void> initializeRecettes() async {
    recettes = await dashbordService.afficherrecettes();
    setState(() {});
  }

  // List<Recette> getRecettesTrieesParDate() {
  //   recettes.sort((a, b) => b.dateAjout!.compareTo(a.dateAjout!));
  //   return recettes;
  // }

  @override
  Widget build(BuildContext context) {
    print("voici la taille de recette");
    print(recettes.length);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor:
                                        Color.fromARGB(255, 140, 121, 65),
                                    backgroundImage:
                                        AssetImage("assets/images/mage2.png"),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Image.asset(
                                      "assets/images/icone.png",
                                      height: 84.0,
                                      width: 84.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //partie gauche
                                Material(
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    width: 180,
                                    // height: 100,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      // color: const Color.fromARGB(255, 234, 221, 221),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Utilisateurs',
                                                style: TextStyle(
                                                    color: secondaryColor,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 20),
                                              FutureBuilder(
                                                  future: utilisateurs,
                                                  builder: (context, snapshot) {
                                                    int? val = snapshot.data;
                                                    return Text(
                                                      '$val',
                                                      style: const TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Image.asset(
                                            'assets/images/Vector.png',
                                            height: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ////2ieme cadre
                                const SizedBox(width: 3.0),
                                Material(
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    width: 220,
                                    // height: 100,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      // color: const Color.fromARGB(255, 234, 221, 221),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Recettes utilisateurs',
                                                style: TextStyle(
                                                    color: secondaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 20),
                                              FutureBuilder(
                                                  future: dishCount,
                                                  builder: (context, snapshot) {
                                                    int? val = snapshot.data;
                                                    return Text(
                                                      '$val',
                                                      style: const TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 59,
                                          height: 50,
                                          child: Icon(
                                            FontAwesomeIcons.mortarPestle,
                                            color: primaryColor,
                                            size: 55,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 3.0),
                                Material(
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    width: 210,
                                    // height: 100,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      // color: const Color.fromARGB(255, 234, 221, 221),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Recettes Admin',
                                                style: TextStyle(
                                                    color: secondaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 20),
                                              FutureBuilder(
                                                  future: recetteAdmin,
                                                  builder: (context, snapshot) {
                                                    int? val = snapshot.data;
                                                    return Text(
                                                      '$val',
                                                      style: const TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 59,
                                          height: 50,
                                          child: Icon(
                                            FontAwesomeIcons.mortarPestle,
                                            color: primaryColor,
                                            size: 55,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Column(
                              children: [
                                const Divider(
                                  color: secondaryColor,
                                ),
                                SizedBox(
                                  height: 400,
                                  child: SingleChildScrollView(
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (Recette recette in recettes)
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            width: 200,
                                            height: 250,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Material(
                                                    elevation: 12,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    child: SizedBox(
                                                      //color: Colors.white,
                                                      height: 130,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            recette.nom ?? '',
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    secondaryColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Positioned(
                                                    width: 500,
                                                    height: 50,
                                                    child: Image.network(
                                                        apiImageUrl +
                                                                recette.photo ??
                                                            ''),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: const EdgeInsets.only(left: 12),
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    width: 1, color: secondaryColor))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Récents"),
                            const Divider(
                              color: primaryColor,
                            ),
                            Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    for (Recette recette in recettes)
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius: 30.0,
                                              backgroundColor: Colors.white,
                                              backgroundImage: Image.network(
                                                      apiImageUrl +
                                                              recette.photo ??
                                                          '')
                                                  .image,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(recette.nom ?? ''),
                                                Text(
                                                  " Prix moyen des condiments ${getPrixTotal(recette.ingredientList!)} Fcfa",
                                                  style: const TextStyle(
                                                      color: secondaryColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                            // Container(
                            //   margin: const EdgeInsets.only(top: 50),
                            //   width: 200,
                            //   height: 240,
                            //   child: Align(
                            //     alignment: Alignment.center,
                            //     child: PieChart(
                            //       PieChartData(
                            //         sectionsSpace: 0,
                            //         centerSpaceRadius: 40,
                            //         pieTouchData: PieTouchData(
                            //           touchCallback: (p0, p1) {
                            //             setState(() {
                            //               // print(p1?.touchedSection
                            //               //     ?.touchedSectionIndex);
                            //               // print("i touched");
                            //             });
                            //           },
                            //         ),
                            //         sections: [
                            //           PieChartSectionData(
                            //             color: Colors.blue,
                            //             value: 40,
                            //             title: '40%',
                            //             radius: 50,
                            //             titleStyle: const TextStyle(
                            //                 fontSize: 16,
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //           PieChartSectionData(
                            //             color: Colors.green,
                            //             value: 30,
                            //             title: '30%',
                            //             radius: 50,
                            //             titleStyle: const TextStyle(
                            //                 fontSize: 16,
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //           PieChartSectionData(
                            //             color: Colors.orange,
                            //             value: 30,
                            //             title: '30%',
                            //             radius: 50,
                            //             titleStyle: const TextStyle(
                            //                 fontSize: 16,
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  double getPrixTotal(List<Ingredient> ingredients) {
    double totalPrix = 0.0;

    for (var ingredient in ingredients) {
      totalPrix += double.parse(ingredient.prix.toString());
    }

    return totalPrix;
  }
}
