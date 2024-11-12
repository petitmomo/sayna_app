import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/firebase_auth_services.dart';
import '../main.dart';
import 'accueil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
                //logo
                child: Image.asset("assets/logo.png",
                    width: 200.0, height: 200.0, fit: BoxFit.cover),
              ),
              const SizedBox(height: 10.0),
              // debut formulaire de connexion
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      // champ email
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Entrer un e-mail";
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
                            return 'Le mot de passe doit contenir au moins 6 caractères';
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
                    // mot de passe oublié
                    Padding(
                      padding: const EdgeInsets.only(right:15.0),
                      child: GestureDetector(
                        onTap:(){
                          Navigator.pushNamed(context, '/reset_password');                        },
                          child: const Row(
                          mainAxisAlignment:MainAxisAlignment.end,
                          children: [
                            Text('Mot de passe oublié'),
                          ],
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
                            // si oui appel à la fonction login
                            _signIn();
                          }
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xFF279BCD)),
                        ),
                        child: const Text('SE CONNECTER',
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
                          const Text("Vous n'avez pas de compte ?"),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/signUp");
                            },
                            child: const Text(
                              "S'inscrire",
                              style: TextStyle(
                                  color: Color(0xffF29D38),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Connexion avec google
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Ou"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
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
                            label: const Text("Se connecter avec google",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    // fin connexion avec google
                  ],
                ),
              ),
              // fin du formumaire de connexion
            ],
          ),
        ),
      ),
    );
  }

  //fonction login
  Future<void> _signIn() async {
    // Vérifier la validation
    if (_formKey.currentState!.validate()) {
      try {
        final User? user = await _authService.signInWithEmail(
          _emailController.text,
          _passwordController.text,
        );
        // Vérifier si user n'est pas null
        if (user != null) {
          // Naviguez vers la page d'accueil après l'authentification
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  const MainScreen()),
          );
        }
      } catch (e) {
        // afficher un snack bar avec un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Identifiant ou mot de passe incorrect,",
          style:TextStyle(color:Colors.white, fontWeight:FontWeight.bold)
          ),
          backgroundColor: Colors.red,
        ),
        
        );
      }
    }
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
}
