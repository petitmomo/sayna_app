
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  // Connexion avec Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user; 

       // Enregistrer les données utilisateur si c'est la première connexion
        if (user != null) {
          final userDoc = await _firestore.collection('users').doc(user.uid).get();
          if (!userDoc.exists) {
            await saveUserData(user, user.displayName?.split(" ")[0] ?? "", user.displayName?.split(" ")[1] ?? "");
          }
        }

        return user;
      }
    } catch (e) {
      print("Erreur de connexion avec Google");
      rethrow; // Relance l'exception pour une gestion plus élevée si besoin
    }
    return null; // Retourne null si la connexion échoue
  }

  // Inscription

  Future<User?> signUpWithEmail(String email, String password,String prenom, String nom) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? user = userCredential.user;


      // Enregistrer les données utilisateur
      if (user != null) {
        await saveUserData(user, prenom, nom);
      }

      return user;

    } catch (e) {
      print("Un compte existe déja avec cet email ");
      rethrow;
    }
  }
  

  // Connexion
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } catch (e) {
      print("Erreur lors de la connexion");
      rethrow;
    }
  }
   // Enregistre les informations de l'utilisateur dans Firestore
  Future<void> saveUserData(User user, String prenom,String nom) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'prenom': prenom,
        'nom': nom,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Erreur lors de l'enregistrement des données utilisateur : ${e.toString()}");
      rethrow;
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
