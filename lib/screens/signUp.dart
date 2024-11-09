import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/firebase_auth_services.dart';
import '../main.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = true;
  final AuthService _authService =
      AuthService(); // import des services d'authentification
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Image.asset("assets/logo.png",
                    width: 200.0, height: 200.0, fit: BoxFit.cover),
              ),
              const SizedBox(height: 10.0),
              // debut formulaire de s'inscription
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // champ prenom
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _prenomController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Entrer un prénom";
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
                          labelText: "Entrer votre prénom",
                        ),
                      ),
                    ),
                    // champ nom
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _nomController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Entrer un email";
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
                          labelText: "Entrer votre nom",
                        ),
                      ),
                    ),
                    // champ email
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Entrer un email";
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Entrer un e-mail valide';
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
                          labelText: "Entrer votre email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      // champ mot de passe
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Entrer un mot de passe";
                          } else if (value.length < 6) {
                            print(
                                'Le mot de passe doit contenir au moins 6 caractères');
                          }
                          return null;
                        },
                        obscureText: _isVisible,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
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
                          labelText: "Entrer votre mot de passe",
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            child: Icon(_isVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                    ),
                    //champ confirmation de mot de passe
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      // champ confirmation du mot de passe
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Confirmer le mot de passe";
                          } else if (value != _passwordController.text) {
                            return 'Les mots de passe ne correspondent pas';
                          }
                          return null;
                        },
                        obscureText: _isVisible,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
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
                          labelText: "Confirmer votre mot de passe",
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            child: Icon(_isVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      //Button de connexion
                      child: ElevatedButton(
                        onPressed: () {
                          // vérifier si le formulaire est valide
                          if (_formKey.currentState!.validate()) {
                            // si oui appel à la fonction signUp
                            _signUp();
                          }
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xFF279BCD)),
                        ),
                        child: const Text('S\'INSCRIRE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Vous avez déja un compte ?"),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/");
                            },
                            child: const Text(
                              "Se connecter",
                              style: TextStyle(
                                  color: Color(0xffF29D38),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // S'inscrire avec google
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Ou"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom:20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              _signInWithGoogle();
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xFF000000)),
                            ),
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                              color: Color(0xFF4285F4), // Couleur de l'icône
                              size: 20.0,
                            ),
                            label: const Text("S'inscrire avec google",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    // fin s'inscrire avec google
                  ],
                ),
              ),
              // fin du formumaire d'inscription
            ],
          ),
        ),
        
      ),
    );
  }
  
    //  fonction connexion avec google
  Future<void> _signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        // Naviguer vers l'écran d'accueil si la connexion réussit
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        // Affiche un message si la connexion échoue
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Connexion annulée ou échouée")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur de connexion avec Google")),
      );
    }
  }
  // Fonction signUp
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final User? user = await _authService.signUpWithEmail(
          _emailController.text,
          _passwordController.text,
          _prenomController.text,
          _nomController.text,
        );
        if (user != null) {
          // Naviguez vers la page de connexion
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Un compte existe déja avec cet email",
          style:TextStyle(color:Colors.white, fontWeight:FontWeight.bold)
          ),
          backgroundColor: Colors.red),
        );
      }
    }
  }
}
