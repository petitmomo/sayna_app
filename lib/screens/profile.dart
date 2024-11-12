import 'package:flutter/material.dart';
import 'package:sayna_app/auth/firebase_auth_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 final AuthService _authService =
      AuthService(); 
  // Lien de l'application (par exemple, vers le Play Store ou l'App Store)
  final String appLink = 'https://play.google.com/store/apps/details?id=com.example.sayna_app';
      
  // Déconnexion
  Future<void> signOut() async {
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false, // Supprime le bouton de retour
        title: const Center(
             child: Text("Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
        backgroundColor: const Color(0xFF279BCD),// couleur app Bar
      ),
        body: Column(
        children: [
          // Section pour les options de profil
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                // edite profile
                Container(
                  height:50.0,
                  decoration:BoxDecoration(
                    color:Colors.white,
                    borderRadius:BorderRadius.circular(60.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/edit_profile'); // Navigue vers l'écran de modification du profil
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.person, size: 30, color:Color(0xFFF29D38)),
                          SizedBox(width: 10.0),
                          Text(
                            'Modifier le profil',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
               
                const SizedBox(height:10.0),
                 // Section de déconnexion
                Container(
                  height:50.0,
                  decoration:BoxDecoration(
                    color:Colors.white,
                    borderRadius:BorderRadius.circular(60.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      signOut();
                      Navigator.pushNamed(context, '/'); // Navigue vers login
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.logout, size: 30, color:Color(0xFFF29D38)),
                          SizedBox(width: 10.0),
                          Text(
                            'Se déconnecter',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
     backgroundColor: const Color(0XFFF2F3F4),// couleur de la page
    );
  }
}
