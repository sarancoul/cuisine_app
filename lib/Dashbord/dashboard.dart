import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   static const appTitle = 'Drawer Demo';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: appTitle,
//       home: DashboardPage(title: appTitle),
//     );
//   }
// }

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
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Accueil',
      style: optionStyle,
    ),
    Text(
      'Index 1: Utilisateur',
      style: optionStyle,
    ),
    Text(
      'Index 2: Recette',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 195, 77, 69),
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Accueil'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Utilisateur'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Recette'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
