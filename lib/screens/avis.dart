import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AvisClient extends StatelessWidget {
  final String professionelId;
  AvisClient({super.key, required this.professionelId});
  

  // controlleur pour récupérer les avis
  final TextEditingController _avisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Avis des clients',
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Afficher les avis existants
            const Text('Avis des clients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                // récupérer les avis depuis la collection avis
                stream: FirebaseFirestore.instance
                    .collection('professionels')
                    .doc(professionelId)
                    .collection('avis')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final avis = snapshot.data!.docs;
                  if (avis.isEmpty) {
                    return const Center(child: Text('Aucun avis disponible.'));
                  }

                  return ListView(
                    children: avis.map((avis) {
                      final comment = avis['comment'];
                      final date = avis['date'] != null
                          ? DateFormat('dd/MM/yyyy').format(
                            (avis['date'] as Timestamp).toDate())
                          : 'Inconnu';
                          final heure = avis['date'] != null
                          ? DateFormat('HH:mm').format(
                            (avis['date'] as Timestamp).toDate())
                          : 'Inconnu';

                      return Card(
                        color:Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: ListTile(
                          title: Text(comment),
                          subtitle: Text('Posté le: $date à $heure',
                          style:const TextStyle(fontWeight:FontWeight.bold)),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Section pour donner un avis
            const Divider(color:Colors.white),
            const Text('Donner votre avis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              maxLength:150,
              controller: _avisController,
              decoration: InputDecoration(hintText: 'Entrez votre avis ici',
              suffixIcon:IconButton(
                icon:const Icon(Icons.send,color:Colors.blue),
                onPressed:(){ // enregister l'avis dans la collection avis
                  FirebaseFirestore.instance
                    .collection('professionels')
                    .doc(professionelId)
                    .collection('avis')
                    .add({
                  'comment': _avisController.text,
                  'date': FieldValue.serverTimestamp(),
                });
                _avisController.clear();
                }
              )
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0XFFF2F3F4),// couleur de la page// couleur de la page // couleur arrière plan de la page
    );
  }
}