import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_provider.dart';
import 'card_page.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({super.key});

  Future<Map<String, dynamic>?> getFoodTruckInfo(String id) async {
    final doc = await FirebaseFirestore.instance.collection('foodTrucks').doc(id).get();
    return doc.exists ? doc.data() : null;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final groupedItems = <String, List<Map<String, dynamic>>>{};

    for (var item in cartProvider.items) {
      final foodTruckId = item['foodTruckId'];
      if (!groupedItems.containsKey(foodTruckId)) {
        groupedItems[foodTruckId] = [];
      }
      groupedItems[foodTruckId]!.add(item);
    }

    final foodTruckIds = groupedItems.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Paniers'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: foodTruckIds.length,
        itemBuilder: (context, index) {
          final foodTruckId = foodTruckIds[index];
          final items = groupedItems[foodTruckId]!;

          final total = items.fold(
              0.0, (sum, item) => sum + (item['prix'] * item['quantity']));

          return FutureBuilder<Map<String, dynamic>?>(
            future: getFoodTruckInfo(foodTruckId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final foodTruck = snapshot.data;

              if (foodTruck == null) {
                return const SizedBox.shrink();
              }

              return Card(
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              foodTruck['logoUrl'] ?? '',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  foodTruck['nom'] ?? 'Nom inconnu',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  foodTruck['adresse'] ?? '',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ...items.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                                '${item['nom']} x${item['quantity']} • ${item['prix'] * item['quantity']} \$'),
                          )),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total : ${total.toStringAsFixed(2)} \$'),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      CartPage(foodTruckId: foodTruckId),
                                ),
                              );
                            },
                            child: const Text("Voir panier"),
                          ),
                        ],
                      ),
                    ],
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
