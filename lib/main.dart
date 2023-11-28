import 'package:flutte_cuisine/Dashbord/accueil.dart';
import 'package:flutte_cuisine/Dashbord/dashboard.dart';
import 'package:flutte_cuisine/Dashbord/page_connexion.dart';
import 'package:flutte_cuisine/Dashbord/recetteListedash.dart';
import 'package:flutte_cuisine/pages/accueil.dart';
import 'package:flutte_cuisine/pages/ajouterrecette.dart';
import 'package:flutte_cuisine/pages/inscription.dart';
import 'package:flutte_cuisine/pages/login.dart';
import 'package:flutte_cuisine/pages/navigation.dart';
import 'package:flutte_cuisine/pages/profil.dart';
import 'package:flutte_cuisine/provider/util_provider.dart';
//import 'package:flutte_cuisine/pages/profil.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UtilProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/Inscription': (context) => const Inscription(),
        '/LoginPage': (context) => const LoginPage(),
        '/accueil': (context) => const Accueil(),
        '/Profil': (context) => const Profil(),
        '/AjouterRecette': (context) => AjouterRecette(),
        '/Navigation': (context) => const Navigation(),
        '/Login': (context) => const Login(),
        '/': (context) => const DashboardPage(
              title: 'Dashboard',
            ),
        '/AccueilDashboard': (context) => const AccueilDashboard(),
        '/RecetteAjout': (context) => const RecetteAjout(),
      },
    );
  }
}
