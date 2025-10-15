import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Map<String, bool> isFavorite = {};

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Connectez-vous pour voir vos favoris.')),
      );
    }

    final favoritesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        automaticallyImplyLeading: false,
        title: const Text(
          'Mes favoris',
          style: TextStyle(
            color: Color(0xFFFF2B2B),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: favoritesRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(
              child: Text(
                "Aucun food truck favori.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            );
          }

          // Initialisation de l'état des favoris
          if (isFavorite.isEmpty) {
            for (var doc in docs) {
              final truckId = doc.id;
              isFavorite[truckId] = true;
            }
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final truck = docs[index].data() as Map<String, dynamic>;
              final truckId = docs[index].id;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // Ajoutez ici une action si nécessaire
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: truck['imageUrl'] != null &&
                                    truck['imageUrl'].toString().isNotEmpty
                                ? Image.network(
                                    truck['imageUrl'],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.store,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  truck['nom'] ?? 'Nom du food truck',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF2B2B),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  truck['description'] ?? 'Aucune description',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite[truckId] == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite[truckId] == true
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () async {
                              final uid = user.uid;
                              final favRef = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('favorites')
                                  .doc(truckId);

                              setState(() {
                                isFavorite[truckId] =
                                    !(isFavorite[truckId] ?? false);
                              });

                              if (isFavorite[truckId]!) {
                                await favRef.set(truck);
                              } else {
                                await favRef.delete();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
