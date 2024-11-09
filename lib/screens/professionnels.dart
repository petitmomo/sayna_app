import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'avis.dart';
import 'reservation_page.dart';

class ListProfessionnels extends StatefulWidget {
  final String categoryTitle;

  const ListProfessionnels({super.key, required this.categoryTitle});

  @override
  State<ListProfessionnels> createState() => _ListProfessionnelsState();
}

class _ListProfessionnelsState extends State<ListProfessionnels> {
  bool isSearching = false;
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: isSearching
            ? TextField(
                decoration: const InputDecoration(
                  hintText: 'Rechercher...',
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query.toLowerCase();
                  });
                },
              )
              :
              Text(widget.categoryTitle,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
        
        actions: [
          // bouton de recherche
              IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search,
            size:28, color:Colors.white),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) searchQuery = ''; // Réinitialise la recherche
              });
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              size: 28, color: Colors.white), // Icône de retour
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
        backgroundColor: const Color(0xFF279BCD),// couleur app Bar
      ),
      // body
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('professionels')
            .where('categorie', isEqualTo: widget.categoryTitle)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child:
                    Text('Aucun professionnel trouvé pour cette catégorie.'));
          }
          // filter les professionnels par prenom et nom puis retourner la requete
          final professionels = snapshot.data!.docs.where((professionel) {
            final name = '${professionel['prenom']} ${professionel['nom']}';
            return name.toLowerCase().contains(searchQuery);
          }).toList();
          //final uniqueProfessionels = {for (var p in professionels) p['id']: p}.values.toList();

          return ListView.builder(
            itemCount: professionels.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: professionels.map((professionel) {
                      final professionelId = professionel.id;
                      final prenom = professionel['prenom'];
                      final nom = professionel['nom'];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Card(
                          color:Colors.white,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SizedBox(
                            height: 150.0,
                            width: double
                                .infinity, // Prend toute la largeur de l'écran
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 10.0,
                                  right: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '$prenom',
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      // note des professionnels
                                      RatingBar.builder(
                                        initialRating:
                                            professionel['note']?.toDouble() ??
                                                0.0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 25,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Color(0xFFF29D38),
                                        ),
                                        onRatingUpdate: (newRating) {
                                          // Mettre à jour la note dans Firestore
                                          FirebaseFirestore.instance
                                              .collection('professionels')
                                              .doc(professionelId)
                                              .update({'note': newRating});
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '$nom',
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    widget.categoryTitle,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children:[
                                      // bouton réserver
                                     ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder:(context) =>ReservationPage(professionelId:professionelId,
                                             prenom:prenom, nom:nom,categorie: widget.categoryTitle,
                                             ),
                                           )
                                         );
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                            Color(0xFF279BCD)),
                                      ),
                                      child:const Text('Réserver',
                                      style: TextStyle(color:Colors.white,
                                      fontSize:20))
                                      ),
                                     GestureDetector(
                                       onTap:(){
                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder:(context) =>AvisClient(professionelId:professionelId,
                                             
                                             ),
                                           )
                                         );
                                       },
                                        child: const Text('Avis client',
                                        style: TextStyle(
                                          fontSize:20,
                                          fontWeight:FontWeight.bold,
                                        )),
                                     ),
                                    ]
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: const Color(0XFFF2F3F4),// couleur de la page/ couleur de la page // couleur arrière plan de la page
    );
  }
}
