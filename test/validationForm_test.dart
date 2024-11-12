import 'package:flutter_test/flutter_test.dart';
import 'package:sayna_app/screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Validation des champs de connexion', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Taper sur le bouton de connexion sans remplir les champs
    await tester.tap(find.text('SE CONNECTER'));
    await tester.pump();

    // Vérifiez que les messages d'erreur sont affichés
    expect(find.text("Entrer un e-mail"), findsOneWidget);
    expect(find.text("Entrer un mot de passe"), findsOneWidget);
  });
}
