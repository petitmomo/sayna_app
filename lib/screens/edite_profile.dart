import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
   final TextEditingController _prenomController = TextEditingController();
   final TextEditingController _nomController = TextEditingController();
   final TextEditingController _emailController = TextEditingController();
   final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   

  @override

  void initState() {
    super.initState();
    _loadUserData();
  }
  // Fonction pour charger les informations de l'utilisateur connecté
  Future<void> _loadUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          setState(() {
            _prenomController.text = userDoc['prenom'] ?? '';
            _nomController.text = userDoc['nom'] ?? '';
            _emailController.text = userDoc['email'] ?? '';
            
          });
        }
      } catch (e) {
        print("Erreur lors du chargement des données de l'utilisateur");
      }
    }
  }

  // Fonction pour sauvegarder les modifications de profil
  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final User? user = _auth.currentUser;
      if (user != null) {
        try {
          await _firestore.collection('users').doc(user.uid).update({
            'prenom': _prenomController.text,
            'nom': _nomController.text,
            'email': _emailController.text,
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profil mis à jour avec succès",style:
              TextStyle(color:Colors.white)),
              backgroundColor:Colors.green,
              )
              );
        } catch (e) {
          print("Erreur lors de la sauvegarde des données : $e");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Modifier le profile",
         style: TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.bold,
         )),
          leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              size: 28, color: Colors.white), // Icône de retour
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
        backgroundColor: const Color(0xFF279BCD),// couleur app Bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
                // champ prénom
                TextFormField(
                  controller: _prenomController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Entrer votre prénom";
                    }
            
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Color(0xFFF29D38), width: 1.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                        color: Color(0xFF279BCD), width: 1.0)),
                    labelText: "Prénom",
                  ),
                ),
              const SizedBox(height: 10.0),
              // champ nom
                  TextFormField(
                  controller: _nomController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Entrer votre nom";
                    }
            
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Color(0xFFF29D38), width: 1.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                        color: Color(0xFF279BCD), width: 1.0)),
                    labelText: "Nom",
                  ),
                ),
             
                const SizedBox(height: 10.0),// espace de 10
                // champ email
                  TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Entrer votre email";
                    }
            
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Color(0xFFF29D38), width: 1.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                        color: Color(0xFF279BCD), width: 1.0)),
                    labelText: "Email",
                  ),
                ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _saveProfile();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF279BCD),
                ),
                child: const Text(
                  'Enregistrer les modifications',
                  style: TextStyle(fontSize: 18,color:Colors.white,fontWeight:FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}