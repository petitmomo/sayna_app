import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:sayna_app/screens/accueil.dart';

void main() {
  testWidgets('Afficher toutes les catégories avec leurs icônes et titres', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AccueilScreen()));

    // Vérifie que chaque titre de catégorie est affiché
    expect(find.text('Plombier'), findsOneWidget);
    expect(find.text('Électricien'), findsOneWidget);
    expect(find.text('Jardinier'), findsOneWidget);
    expect(find.text('Ménager'), findsOneWidget);
    expect(find.text('Menuisier'), findsOneWidget);
    expect(find.text('Peintre'), findsOneWidget);

    // Vérifie qu'un nombre correct de catégories est affiché
    expect(find.byType(Card), findsNWidgets(6));
  });
}
