import 'package:flutter/material.dart';

import 'professionnels.dart';

class AccueilScreen extends StatefulWidget {
  //final String professionelId;
  const AccueilScreen({super.key});

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  // Liste des catégories avec des icônes et des titres
  final List<Map<String, dynamic>> categories = [
    {"id":"1","title": "Plombier", "icon": Icons.plumbing},
    {"id":"2", "title": "Électricien", "icon": Icons.electrical_services},
    {"id":"3","title": "Jardinier", "icon": Icons.grass},
    {"id":"4","title": "Ménage", "icon": Icons.cleaning_services},
    {"id":"5","title": "Menuisier", "icon": Icons.handyman},
    {"id":"6","title": "Peintre", "icon": Icons.format_paint},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title:  Row(
         // mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/logo.png',
            width: 60.0, height: 60.0,),
            const SizedBox(width: 20),
            const Text('Catégories de Services', style:TextStyle(
              color:Colors.white, fontWeight:FontWeight.bold,
            )),
            
          ],
        ),
        backgroundColor: const Color(0xFF279BCD),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Nombre de colonnes dans la grille
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                // Naviguer vers la page des professionnels
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListProfessionnels(
                    categoryTitle: category['title'],
                   // professionelId:professionelId,
                  ),
                ),
              );
            },
              child: Card(
                color:Colors.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category['icon'],
                      size: 50,
                      color: const Color(0xFFF29D38),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      category['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: const Color(0XFFF2F3F4),// couleur de la page// couleur arrière plan de la page
    );
  }
}
