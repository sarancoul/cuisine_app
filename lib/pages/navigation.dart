import 'package:flutte_cuisine/pages/accueil.dart';
import 'package:flutte_cuisine/pages/ajouterrecette.dart';
import 'package:flutte_cuisine/pages/discussions.dart';
import 'package:flutte_cuisine/pages/profil.dart';
import 'package:flutte_cuisine/provider/util_provider.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

List<Widget> tabs = [
  const Accueil(),
  AjouterRecette(),
  const Discussions(),
  const Profil()
];

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<UtilProvider>(context).clientCurrentIndex;
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        fixedColor: primaryColor,
        unselectedItemColor: Colors.white,
        onTap: (int index) {
          context.read<UtilProvider>().setclientCurrentIndex(index);
          // setState(() {
          //   currentIndex = index;
          // });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: currentIndex == 0 ? primaryColor : Colors.white,
              ),
              label: 'Home',
              backgroundColor: const Color.fromRGBO(113, 111, 111, 1)),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: currentIndex == 1 ? primaryColor : Colors.white,
              ),
              label: 'Ajouter',
              backgroundColor: const Color.fromARGB(255, 113, 111, 111)),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: currentIndex == 2 ? primaryColor : Colors.white,
              ),
              label: 'Discussionss',
              backgroundColor: const Color.fromARGB(255, 113, 111, 111)),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: currentIndex == 3 ? primaryColor : Colors.white,
              ),
              label: 'Profil',
              backgroundColor: const Color.fromARGB(255, 113, 111, 111)),
        ],
      ),
    );
  }
}
