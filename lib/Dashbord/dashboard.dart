import 'package:flutte_cuisine/Dashbord/ajouterrecette.dart';
import 'package:flutte_cuisine/Dashbord/recetteListedash.dart';
import 'package:flutte_cuisine/Dashbord/utilisateur.dart';
import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/provider/util_provider.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.title});

  final String title;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[];
  bool nextPage = false;
  Recette recette = Recette();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _widgetOptions = <Widget>[
    //   const AccueilDashboard(),
    //   const ProfilePage(),
    //   const RecetteAjout(),
    //   !nextPage
    //       ? AjouterRecette(
    //           changePage: changePage,
    //         )
    //       : AjouterRecetteSecondePage(
    //           changePage: changePage,
    //           recette: recette,
    //         )
    // ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void changePage(Recette recetteU) {
    setState(() {
      recette = recetteU;
      print("je change de page");
      print(recette.toJson());
      nextPage = true;
      print("change");
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = Provider.of<UtilProvider>(context).dashboardCurrentIndex;
    _widgetOptions = Provider.of<UtilProvider>(context).widgetOptions;

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .2,
            color: secondaryColor, // Set the background color
            padding: const EdgeInsets.only(top: 60, left: 13, right: 13),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color:
                          _selectedIndex == 0 ? primaryColor : secondaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: ListTile(
                    title: const Text('Accueil',
                        style: TextStyle(color: Colors.white)),
                    leading:
                        const Icon(FontAwesomeIcons.house, color: Colors.white),
                    tileColor:
                        Colors.orange, // Set the background color for this tile
                    selected: _selectedIndex == 0,
                    onTap: () {
                      context
                          .read<UtilProvider>()
                          .setdashboardCurrentIndex(getIndex(DashboardPage));
                      // _onItemTapped(0);
                      // Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:
                          _selectedIndex == 1 ? primaryColor : secondaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: ListTile(
                    title: const Text('Utilisateur',
                        style: TextStyle(color: Colors.white)),
                    leading:
                        const Icon(FontAwesomeIcons.users, color: Colors.white),
                    tileColor:
                        Colors.orange, // Set the background color for this tile
                    selected: _selectedIndex == 1,
                    onTap: () {
                      context
                          .read<UtilProvider>()
                          .setdashboardCurrentIndex(getIndex(ProfilePage));
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:
                          _selectedIndex == 2 ? primaryColor : secondaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: ListTile(
                    title: const Text(
                      'Recette',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: const Icon(
                      FontAwesomeIcons.mortarPestle,
                      color: Colors.white,
                    ),
                    tileColor:
                        Colors.orange, // Set the background color for this tile
                    selected: _selectedIndex == 2,
                    onTap: () {
                      context
                          .read<UtilProvider>()
                          .setdashboardCurrentIndex(getIndex(RecetteAjout));
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:
                          _selectedIndex == 3 ? primaryColor : secondaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: ListTile(
                    title: const Text(
                      'Ajout Recette',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: const Icon(
                      FontAwesomeIcons.mortarPestle,
                      color: Colors.white,
                    ),
                    tileColor:
                        Colors.orange, // Set the background color for this tile
                    selected: _selectedIndex == 3,
                    onTap: () {
                      context.read<UtilProvider>().setRecette(Recette());
                      context.read<UtilProvider>().setdashboardCurrentIndex(
                          getIndex(AjouterRecetteDash));
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _widgetOptions[_selectedIndex]),
        ],
      ),
    );
  }

  int getIndex(Type className) {
    int indexRecetteAjout = 0;

    for (int i = 0; i < _widgetOptions.length; i++) {
      print(_widgetOptions[i].runtimeType == className);

      if (_widgetOptions[i].runtimeType == className) {
        indexRecetteAjout = i;
        break;
      }
    }

    print("L'index de RecetteAjout est : $indexRecetteAjout");
    return indexRecetteAjout;
  }
}
