import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:sayna_app/screens/professionnels.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  testWidgets('Recherche des professionnels', (WidgetTester tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: ListProfessionnels(categoryTitle: 'Plombier'),
      ),
    );

    // Simuler la saisie de recherche
    await tester.enterText(find.byType(TextField), 'Dupont');
    await tester.pump();

    // Assurez-vous que la liste de professionnels a été filtrée
    expect(find.text('Dupont'), findsWidgets);
  });
}
