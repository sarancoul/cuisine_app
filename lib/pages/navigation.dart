import 'package:flutte_cuisine/pages/accueil.dart';
import 'package:flutte_cuisine/pages/ajouterrecette.dart';
import 'package:flutte_cuisine/pages/discussions.dart';
import 'package:flutte_cuisine/pages/profil.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';

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
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        fixedColor: primaryColor,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 113, 111, 111)),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Ajouter',
              backgroundColor: Color.fromARGB(255, 113, 111, 111)),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Discussionss',
              backgroundColor: Color.fromARGB(255, 113, 111, 111)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
              backgroundColor: Color.fromARGB(255, 113, 111, 111)),
        ],
      ),
    );
  }
}
