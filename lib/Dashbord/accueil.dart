import 'package:fl_chart/fl_chart.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';

class AccueilDashboard extends StatefulWidget {
  const AccueilDashboard({super.key});

  @override
  State<AccueilDashboard> createState() => _AccueilDashboardState();
}

class _AccueilDashboardState extends State<AccueilDashboard> {
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
                    child: const TextField(
                      style: TextStyle(fontSize: 12.0),
                      decoration: InputDecoration(
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
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //partie gauche
                          Container(
                            width: 250,
                            height: 250,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 234, 221, 221),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  children: [
                                    Text(
                                      'Utilisateurs',
                                      style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '4',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 60,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Container(
                                    child: Image.asset(
                                  'assets/images/Vector.png',
                                  height: 70,
                                ))
                              ],
                            ),
                          ),
                          const SizedBox(width: 100.0),
                          //partie milieu
                          Container(
                            width: 250,
                            height: 250,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 225, 225),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Recettes",
                                      style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '10',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: AssetImage(
                                          "assets/images/poulet_bienvenu.jpg"),
                                    ),
                                    SizedBox(width: 14.0),
                                    Text(
                                      "Poulet",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: AssetImage(
                                          "assets/images/poulet_bienvenu.jpg"),
                                    ),
                                    SizedBox(width: 14.0),
                                    Text(
                                      "Poulet",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 100.0),
                          //partie droite
                          Container(
                            width: 250,
                            height: 250,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 235, 225, 225),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Recettes",
                                      style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '10',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: AssetImage(
                                          "assets/images/poulet_bienvenu.jpg"),
                                    ),
                                    SizedBox(width: 14.0),
                                    Text(
                                      "Poulet",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: AssetImage(
                                          "assets/images/poulet_bienvenu.jpg"),
                                    ),
                                    SizedBox(width: 14.0),
                                    Text(
                                      "Poulet",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 235, 225, 225),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 0,
                                centerSpaceRadius: 40,
                                sections: [
                                  PieChartSectionData(
                                    color: Colors.blue,
                                    value: 40,
                                    title: '40%',
                                    radius: 50,
                                    titleStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: 30,
                                    title: '30%',
                                    radius: 50,
                                    titleStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.orange,
                                    value: 30,
                                    title: '30%',
                                    radius: 50,
                                    titleStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 400,
                            height: 200,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 235, 225, 225),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: LineChart(
                              LineChartData(
                                gridData: const FlGridData(show: false),
                                titlesData: const FlTitlesData(show: false),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: const Color(0xff37434d), width: 1),
                                ),
                                minX: 0,
                                maxX: 7,
                                minY: 0,
                                maxY: 6,
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: [
                                      const FlSpot(0, 3),
                                      const FlSpot(1, 1),
                                      const FlSpot(2, 4),
                                      const FlSpot(3, 2),
                                      const FlSpot(4, 5),
                                      const FlSpot(5, 1),
                                      const FlSpot(6, 4),
                                    ],
                                    isCurved: true,
                                    color: secondaryColor,
                                    dotData: const FlDotData(show: false),
                                    belowBarData: BarAreaData(show: false),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
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
}
