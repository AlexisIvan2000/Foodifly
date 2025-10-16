import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodOrderPage extends StatelessWidget {
  final String foodTruckId;

  FoodOrderPage({required this.foodTruckId});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'reçu':
        return Colors.redAccent;
      case 'en cours':
        return Colors.orange;
      case 'terminée':
        return Colors.green;
      case 'récupérer':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'reçu':
        return Icons.download_rounded;
      case 'en cours':
        return Icons.access_time;
      case 'terminée':
        return Icons.check_circle;
      case 'récupérer':
        return Icons.shopping_bag;
      default:
        return Icons.help_outline;
    }
  }

  Widget _buildOrderCard(Map<String, dynamic> order, int index) {
    final items = order['itemsSummary'] ?? [];
    final total = order['total'] ?? 0.0;
    final status = order['status'] ?? 'inconnu';
    final itemCount = order['itemCount'] ?? 0;
    final date = (order['timestamp'] as Timestamp?)?.toDate();

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + index * 100),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(offset: Offset(0, (1 - value) * 20), child: child),
        );
      },
      child: Card(
        elevation: 6,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        shadowColor: Colors.black12,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("🧾 Commande #${index + 1}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              if (date != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    DateFormat('dd MMM yyyy – HH:mm').format(date),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              Divider(height: 20, thickness: 1),
              ...items.map<Widget>((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      if (item['imageUrl'] != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(item['imageUrl'],
                              width: 40, height: 40, fit: BoxFit.cover),
                        ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(item['nom'] ?? 'Item inconnu',
                            style: TextStyle(fontSize: 14)),
                      ),
                      Text(
                        "\$${(item['prix'] ?? 0).toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              }).toList(),
              Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("🧮 Items : $itemCount", style: TextStyle(fontSize: 14)),
                  Text("💵 Total: \$${total.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _statusColor(status).withOpacity(0.2),
                    ),
                    child: Icon(_statusIcon(status),
                        color: _statusColor(status), size: 20),
                  ),
                  SizedBox(width: 8),
                  Text(
                    status.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _statusColor(status)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Stream<List<Map<String, dynamic>>> _getOrdersForFoodTruck() {
    return FirebaseFirestore.instance
        .collectionGroup('orders')
        .where('foodTruckId', isEqualTo: foodTruckId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commandes du Food Truck',
            style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: const Color.fromARGB(255, 209, 61, 61),
        leading: BackButton(),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _getOrdersForFoodTruck(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return Center(
              child: Text("Aucune commande trouvée.",
                  style: TextStyle(fontSize: 16)),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return _buildOrderCard(orders[index], index);
            },
          );
        },
      ),
    );
  }
}
