import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'orders_page.dart';
import 'payment.dart';

class CartPage extends StatelessWidget {
  final String foodTruckId;

  const CartPage({
    super.key,
    required this.foodTruckId,
  });

  double getTax(double subtotal) => subtotal * 0.12;

  void _showSavedCardsBottomSheet(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('utilisateurs')
        .doc(user.uid)
        .collection('cartes')
        .get();

    final cartes = snapshot.docs.map((doc) => doc.data()).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.4,
          widthFactor: 1.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Vos cartes enregistrées",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: cartes.isEmpty
                      ? const Center(child: Text("Aucune carte enregistrée"))
                      : ListView.builder(
                          itemCount: cartes.length,
                          itemBuilder: (context, index) {
                            final carte = cartes[index];
                            final numero = carte['numero'] ?? '';
                            final dernieres4 = numero.length >= 4
                                ? numero.substring(numero.length - 4)
                                : numero;

                            return ListTile(
                              leading: const Icon(Icons.credit_card),
                              title: Text('**** **** **** $dernieres4'),
                              subtitle: Text(carte['nom'] ?? ''),
                              onTap: () => _submitCard(context),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentPage(),
                          ),
                        );
                      },
                      icon: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFFFF2B2B),
                          size: 18,
                        ),
                      ),
                      label: const Text("Ajouter une carte"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF2B2B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitCard(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final uid = user.uid;
  final cartProvider = Provider.of<CartProvider>(context, listen: false);

  if (cartProvider.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Votre panier est vide.')),
    );
    return;
  }

  final total = cartProvider.total;
  final foodTruckId = cartProvider.foodTruckId;
  final foodTruckName = cartProvider.foodTruckName;

  if (foodTruckId == null || foodTruckName == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Food truck inconnu.')),
    );
    return;
  }

  final menuCount =
      cartProvider.items.map((item) => item['menuId']).toSet().length;

  final itemCount = cartProvider.items.fold<int>(
    0,
    (sum, item) => sum + (item['quantity'] as int),
  );

  final itemsSummary = cartProvider.items.map((item) {
    return {
      'id': item['id'],
      'nom': item['nom'],
      'prix': item['prix'],
      'imageUrl': item['imageUrl'],
    };
  }).toList();

  // Création de la commande
  final orderRef = await FirebaseFirestore.instance.collection('orders').add({
    'userId': uid,
    'foodTruckId': foodTruckId,
    'foodTruckName': foodTruckName,
    'timestamp': FieldValue.serverTimestamp(),
    'total': total,
    'status': 'reçu',
    'menuCount': menuCount,
    'itemCount': itemCount,
    'itemsSummary': itemsSummary,
  });

  // Ajout des items dans une sous-collection
  for (var item in cartProvider.items) {
    await orderRef.collection('items').add({
      'nom': item['nom'],
      'prix': item['prix'],
      'quantity': item['quantity'],
      'imageUrl': item['imageUrl'],
    });
  }

  _startOrderStatusUpdate(orderRef); // Ta logique de mise à jour du statut

  cartProvider.clearCart();

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Commande effectuée avec succès')),
  );

  // ✅ Naviguer vers la page de détails avec l'ID de la commande
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => OrderDetailPage(orderId: orderRef.id),
    ),
  );
}


  void _startOrderStatusUpdate(DocumentReference orderRef) async {
    Future.delayed(const Duration(seconds: 10), () {
      orderRef.update({'status': 'en préparation'});
    });
    Future.delayed(const Duration(seconds: 20), () {
      orderRef.update({'status': 'terminée'});
    });
    Future.delayed(const Duration(seconds: 30), () {
      orderRef.update({'status': 'récupérer'});
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;
    final subtotal = cartProvider.subtotal;
    final tax = cartProvider.tax;
    final total = cartProvider.total;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6E9),
      appBar: AppBar(
        title: const Text("Panier"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.network(
                        item['imageUrl'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item['nom']),
                      subtitle: Text('${item['prix'].toStringAsFixed(2)} \$'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () =>
                                cartProvider.decrementQuantity(item['nom']),
                          ),
                          Text('${item['quantity']}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () =>
                                cartProvider.incrementQuantity(item['nom']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Compléter le panier",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 160,
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('items')
                    .where('foodTruck',
                        isEqualTo: FirebaseFirestore.instance
                            .doc('foodTrucks/$foodTruckId'))
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('Aucun article à suggérer.'));
                  }

                  final suggestionItems = snapshot.data!.docs;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: suggestionItems.length,
                    itemBuilder: (context, index) {
                      final itemData =
                          suggestionItems[index].data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () => cartProvider.addToCart(itemData),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  itemData['imageUrl'] ?? '',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 90,
                                    height: 90,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.fastfood,
                                        color: Colors.black45),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                itemData['nom'] ?? '',
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${itemData['prix']} \$',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.white),
                  label: const Text(
                    "Ajouter d'autres articles",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFF2B2B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Sous-total :", style: TextStyle(fontSize: 16)),
                Text('${subtotal.toStringAsFixed(2)} \$'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Taxes estimées :", style: TextStyle(fontSize: 16)),
                Text('${tax.toStringAsFixed(2)} \$'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total :",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('${total.toStringAsFixed(2)} \$',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextButton(
                onPressed: () => _showSavedCardsBottomSheet(context),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFFF2B2B),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Continuer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
