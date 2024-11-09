import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


import 'screens/accueil.dart';
import 'screens/edite_profile.dart';
import 'screens/historique_reservation.dart';
import 'screens/login.dart';
import 'screens/profile.dart';
import 'screens/signUp.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialiser firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sayna app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
     // home: const SignUpScreen(),

      // route initial
      initialRoute: '/',

      //  routes
      routes: {
        '/': (context) => const LoginScreen(),
         '/signUp': (context) => const SignUpScreen(),
          '/accueil': (context) => const  AccueilScreen(),
          '/main': (context) =>  const MainScreen(),
          '/edit_profile': (context) =>  const EditProfile(),
      }
    );
  }
}
// Button de navigation
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Méthode pour changer de page en fonction de l'index sélectionné
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Liste des pages
  final List<Widget> _pages = [
    const AccueilScreen(),
    const ReservationScreen(),
    const ProfileScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Utiliser IndexedStack pour conserver l'état des pages et éviter le rechargement
      body:IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Réservation',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications),
          //   label: 'Notifications',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
    
  }
}

