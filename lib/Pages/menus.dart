import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'card_page.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class MenuPage extends StatefulWidget {
  final String foodTruckId;
  final String foodTruckName;
  final String foodTruckImage;

  const MenuPage({
    super.key,
    required this.foodTruckId,
    required this.foodTruckName,
    required this.foodTruckImage,
  });

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Future<List<Map<String, dynamic>>> fetchMenus() async {
    final menuSnapshot = await FirebaseFirestore.instance
        .collection('menus')
        .where('foodTruck',
            isEqualTo: FirebaseFirestore.instance
                .doc('foodTrucks/${widget.foodTruckId}'))
        .get();

    return menuSnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> fetchItems() async {
    final itemSnapshot = await FirebaseFirestore.instance
        .collection('items')
        .where('foodTruck',
            isEqualTo: FirebaseFirestore.instance
                .doc('foodTrucks/${widget.foodTruckId}'))
        .get();

    return itemSnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  void _addToCart(BuildContext context, Map<String, dynamic> item) {
    final completeItem = {
      ...item, // Cela copie toutes les clés et valeurs de `item`
      'foodTruckId': widget.foodTruckId,
      'foodTruckName': widget.foodTruckName,
    };
    // Ajouter l'item modifié au panier via le CartProvider
    Provider.of<CartProvider>(context, listen: false).addItem(completeItem);

    print(completeItem);

    // Afficher un SnackBar pour informer l'utilisateur que l'item a été ajouté
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['nom']} ajouté au panier'),
        backgroundColor: const Color(0xFFFF2B2B),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F0),
      body: FutureBuilder(
        future: Future.wait([fetchMenus(), fetchItems()]),
        builder: (context,
            AsyncSnapshot<List<List<Map<String, dynamic>>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          final menus = snapshot.data![0];
          final items = snapshot.data![1];

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 230,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(30)),
                        child: Image.network(
                          widget.foodTruckImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error,
                                color: Color(0xFFFF2B2B)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 40,
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 16,
                        child: Text(
                          'Welcome to ${widget.foodTruckName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.transparent,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.foodTruckName,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      const Text('Menus',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      menus.isEmpty
                          ? const Text(
                              'Aucun menu disponible pour ce food truck.')
                          : SizedBox(
                              height: 220,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: menus.length,
                                itemBuilder: (context, index) {
                                  final menu = menus[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: _buildMenuCard(context, menu),
                                  );
                                },
                              ),
                            ),
                      const Divider(
                        height: 32,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 24),
                      const Text('Items disponibles',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      items.isEmpty
                          ? const Text(
                              'Aucun item disponible pour ce food truck.')
                          : ListView.builder(
                              itemCount: items.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child:
                                      _buildHorizontalItemCard(context, item),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: context.watch<CartProvider>().totalItems > 0
          ? Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFFF2B2B),
                borderRadius: BorderRadius.circular(40),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CartPage(foodTruckId: widget.foodTruckId),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(Icons.shopping_cart,
                              color: Colors.white, size: 24),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.red.shade900,
                            child: Text(
                              '${context.watch<CartProvider>().totalItems}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'VIEW CART',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMenuCard(BuildContext context, Map<String, dynamic> menu) {
    return GestureDetector(
      onTap: () => _addToCart(context, menu),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(menu['imageUrl'] ?? ''),
            fit: BoxFit.cover,
          ),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: 180,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(menu['nom'] ?? '',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('${menu['prix']} \$',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.white),
                onPressed: () => _addToCart(context, menu),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalItemCard(
      BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => _addToCart(context, item),
      child: Container(
        height: 120, // Hauteur augmentée
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(16)),
              child: Image.network(
                item['imageUrl'] ?? '',
                width: 100,
                height: 120,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : const CircularProgressIndicator(),
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 120,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error, color: Color(0xFFFF2B2B)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['nom'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item['prix']} \$',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item['note'] ?? '4.5'} (${item['votes'] ?? '100+'})',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(Icons.add_circle, color: Color(0xFFFF2B2B)),
                onPressed: () => _addToCart(context, item),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
