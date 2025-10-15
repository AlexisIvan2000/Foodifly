import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Pour accéder au CartProvider
import 'menus.dart';
//import 'card_page.dart';
import 'cart_provider.dart'; // À adapter selon ton arborescence
import 'cart_list.dart';
import 'welcome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> allFoodTrucks = [];
  List<Map<String, dynamic>> filteredFoodTrucks = [];
  Map<String, List<String>> foodTruckItemImages = {};
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchFoodTrucks();
    checkFavorites();
  }

  Future<void> checkFavorites() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final favoritesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .get();

      for (var doc in favoritesSnapshot.docs) {
        final truckId = doc.id;
        setState(() {
          isFavorite[truckId] = true;
        });
      }
    }
  }

  Future<void> fetchFoodTrucks() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('foodTrucks').get();
    final trucks =
        snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();

    for (var truck in trucks) {
      await fetchItemImagesForTruck(truck['id']);
    }

    setState(() {
      allFoodTrucks = trucks;
      filteredFoodTrucks = trucks;
    });
  }

  Future<void> fetchItemImagesForTruck(String truckId) async {
    final itemsSnapshot = await FirebaseFirestore.instance
        .collection('items')
        .where('foodTruck',
            isEqualTo: FirebaseFirestore.instance.doc('foodTrucks/$truckId'))
        .limit(2)
        .get();

    final images = itemsSnapshot.docs
        .map((doc) => doc['imageUrl'] as String?)
        .where((url) => url != null && url.isNotEmpty)
        .cast<String>()
        .toList();

    foodTruckItemImages[truckId] = images;
  }

  void _filterFoodTrucks(String query) {
    final filtered = allFoodTrucks.where((truck) {
      final description = (truck['description'] ?? '').toString().toLowerCase();
      return description.contains(query.toLowerCase());
    }).toList();

    setState(() {
      searchQuery = query;
      filteredFoodTrucks = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;
    final itemCount = cartProvider.totalItems;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F0),
      body: Column(
        children: [
          // Barre supérieure avec recherche
          Container(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
            color: const Color(0xFFFF2B2B),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.exit_to_app, color: Colors.white),
                      onPressed: () async {
                        // Déconnexion de Firebase
                        await FirebaseAuth.instance.signOut();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Déconnexion réussie')),
                        );
                        // Rediriger l'utilisateur vers la page de connexion après la déconnexion
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WelcomeScreen()), // Remplace LoginPage par ton widget de login
                          (Route<dynamic> route) =>
                              false, // Retirer toutes les routes précédentes
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on,
                        color: Colors.white, size: 18),
                    const SizedBox(width: 4),
                    const Expanded(
                      child: Text(
                        "725 College Street",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.notifications_none, color: Colors.white),
                    const SizedBox(width: 16),

                    // Panier
                    GestureDetector(
                      onTap: () {
                        if (cartItems.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const CartListPage(), // remplace par ta page listant tous les paniers
                            ),
                          );
                        }
                      },
                      child: Stack(
                        children: [
                          const Icon(Icons.shopping_cart_outlined,
                              color: Colors.white),
                          if (itemCount > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: const BoxConstraints(
                                    minWidth: 16, minHeight: 16),
                                child: Text(
                                  itemCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    onChanged: _filterFoodTrucks,
                    decoration: const InputDecoration(
                      hintText: "Recherche",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Affichage food trucks
          Expanded(
            child: filteredFoodTrucks.isEmpty
                ? const Center(child: Text('Aucun food truck trouvé.'))
                : ListView.builder(
                    itemCount: (filteredFoodTrucks.length / 3).ceil(),
                    itemBuilder: (context, blockIndex) {
                      final startIndex = blockIndex * 3;
                      final endIndex =
                          (startIndex + 3 < filteredFoodTrucks.length)
                              ? startIndex + 3
                              : filteredFoodTrucks.length;

                      final blockTrucks =
                          filteredFoodTrucks.sublist(startIndex, endIndex);

                      final isHorizontalScroll = blockIndex % 3 != 2;

                      return Column(
                        children: [
                          isHorizontalScroll
                              ? SizedBox(
                                  height: 270,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: blockTrucks.length,
                                    itemBuilder: (context, index) {
                                      final truck = blockTrucks[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child:
                                            _buildFoodTruckCard(context, truck),
                                      );
                                    },
                                  ),
                                )
                              : Column(
                                  children: blockTrucks.map((truck) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child:
                                          _buildFoodTruckCard(context, truck),
                                    );
                                  }).toList(),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              height: 2,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Valeurs globales pour chaque carte
  ValueNotifier<String?> focusedTruckId = ValueNotifier<String?>(null);
  Map<String, Timer> imageTimers = {};
  Map<String, int> currentPageIndex = {};
  Map<String, bool> isFavorite = {};

  Widget _buildFoodTruckCard(BuildContext context, Map<String, dynamic> truck) {
    final truckId = truck['id'];
    final itemImages = foodTruckItemImages[truckId] ?? [];
    final pageController = PageController();
    currentPageIndex[truckId] = currentPageIndex[truckId] ?? 0;
    isFavorite[truckId] = isFavorite[truckId] ?? false;

    // Reste inchangé...
    // (je n'ai pas répété le corps entier de _buildFoodTruckCard, il reste le même que ta version)

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuPage(
              foodTruckId: truckId,
              foodTruckName: truck['nom'] ?? 'Food Truck',
              foodTruckImage: truck['imageUrl'] ?? '',
            ),
          ),
        );
      },
      onLongPress: () {
        // Focus au long appui (ou change selon le comportement que tu veux)
        focusedTruckId.value = truckId;
        if (itemImages.length > 1 && !imageTimers.containsKey(truckId)) {
          imageTimers[truckId] =
              Timer.periodic(const Duration(seconds: 2), (_) {
            if (pageController.hasClients) {
              currentPageIndex[truckId] =
                  (currentPageIndex[truckId]! + 1) % itemImages.length;
              pageController.animateToPage(
                currentPageIndex[truckId]!,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          });
        }
      },
      child: ValueListenableBuilder<String?>(
        valueListenable: focusedTruckId,
        builder: (context, focusedId, _) {
          final isFocused = focusedId == truckId;
          return Transform.scale(
              scale: isFocused ? 1.03 : 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // Image (70%)
                    SizedBox(
                      height: 170,
                      child: itemImages.isEmpty
                          ? Container(
                              height: 180,
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(Icons.fastfood,
                                    size: 48, color: Colors.grey),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  PageView.builder(
                                    controller: pageController,
                                    itemCount: itemImages.length,
                                    itemBuilder: (context, index) {
                                      return Image.network(
                                        itemImages[index],
                                        width: double.infinity,
                                        height: 190,
                                        fit: BoxFit.cover,
                                      );
                                    },
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
                                      final user =
                                          FirebaseAuth.instance.currentUser;

                                      if (user != null) {
                                        final uid = user.uid;
                                        final truckId = truck['id'];
                                        final favRef = FirebaseFirestore
                                            .instance
                                            .collection('users')
                                            .doc(uid)
                                            .collection('favorites')
                                            .doc(truckId);

                                        setState(() {
                                          isFavorite[truckId] =
                                              !(isFavorite[truckId] ?? false);
                                        });

                                        // Ajouter ou supprimer le truck des favoris
                                        if (isFavorite[truckId]!) {
                                          await favRef.set(
                                              truck); // Ajouter aux favoris
                                        } else {
                                          await favRef
                                              .delete(); // Retirer des favoris
                                        }
                                      } else {
                                        print('Utilisateur non connecté');
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                    ),

                    // Infos (30%)
                    Container(
                      padding: const EdgeInsets.all(12),
                      height: 100,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundImage: truck['imageUrl'] != null &&
                                    truck['imageUrl'].toString().isNotEmpty
                                ? NetworkImage(truck['imageUrl'])
                                : null,
                            backgroundColor: Colors.grey[300],
                            child: truck['imageUrl'] == null ||
                                    truck['imageUrl'].toString().isEmpty
                                ? const Icon(Icons.store, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  truck['nom'] ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  truck['description'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
