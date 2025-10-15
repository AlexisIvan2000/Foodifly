import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Center(child: Text("Utilisateur non connecté."));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Commandes'),
        centerTitle: true,
        backgroundColor: Color(0xFFFF2B2B),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('userId', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucune commande trouvée.'));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final data = order.data() as Map<String, dynamic>;

              final status = data['status'] ?? 'inconnu';
              final color = _getStatusColor(status);

              final itemsSummary = data['itemsSummary'] != null
                  ? List<Map<String, dynamic>>.from(data['itemsSummary'])
                  : [];

              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          data['foodTruckName'] ?? 'Food Truck inconnu',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text('Commande ID : ${order.id}'),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    OrderDetailPage(orderId: order.id),
                              ),
                            );
                          },
                          child: Text(
                            status.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Menus : ${data['menuCount'] ?? 0}'),
                          Text('Articles : ${data['itemCount'] ?? 0}'),
                          Text(
                            'Total : ${data['total'] ?? 0} €',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      ...itemsSummary.map((item) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: item['imageUrl'] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item['imageUrl'],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(Icons.fastfood, size: 40),
                            title: Text(item['nom'] ?? 'Nom inconnu'),
                            subtitle: Text('${item['prix'] ?? 0} €'),
                          )),
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'reçu':
        return Colors.redAccent;
      case 'en préparation':
        return Colors.orangeAccent;
      case 'terminée':
        return Colors.green;
      case 'récupérer':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }
}

class OrderDetailPage extends StatelessWidget {
  final String orderId;
  const OrderDetailPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la commande'),
        backgroundColor:Color(0xFFFF2B2B), 
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('orders').doc(orderId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final itemsSummary = data['itemsSummary'] != null
              ? List<Map<String, dynamic>>.from(data['itemsSummary'])
              : [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Card Info Commande
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Résumé de la commande',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      _infoRow(
                          'Food Truck :', data['foodTruckName'] ?? 'Inconnu'),
                      _infoRow(
                          'Total :', '${data['total']?.toStringAsFixed(2)} €'),
                      _infoRow('Menus :', '${data['menuCount'] ?? 0}'),
                      _infoRow('Articles :', '${data['itemCount'] ?? 0}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Items commandés
              const Text(
                'Items commandés',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              ...itemsSummary.map(
                (item) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: item['imageUrl'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item['imageUrl'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.fastfood, size: 40),
                    title: Text(item['nom'] ?? 'Nom inconnu'),
                    subtitle: Text('${item['prix']?.toStringAsFixed(2)} €'),
                  ),
                ),
              ),

              const SizedBox(height: 32),
              const Text(
                'Progression de la commande',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              OrderProgressStepper(currentStatus: data['status']),
            ],
          );
        },
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w500),
              )),
          Expanded(
              flex: 3,
              child: Text(
                value,
                style: const TextStyle(color: Colors.black87),
              )),
        ],
      ),
    );
  }
}

class OrderProgressStepper extends StatefulWidget {
  final String currentStatus;
  const OrderProgressStepper({super.key, required this.currentStatus});

  @override
  _OrderProgressStepperState createState() => _OrderProgressStepperState();
}

class _OrderProgressStepperState extends State<OrderProgressStepper> {
  late String currentStatus;
  late Timer _timer;

  static const List<String> statuses = [
    'reçu',
    'en préparation',
    'terminée',
    'récupérer',
  ];

  static const Map<String, IconData> statusIcons = {
    'reçu': Icons.receipt_long,
    'en préparation': Icons.kitchen,
    'terminée': Icons.check_circle,
    'récupérer': Icons.delivery_dining,
  };

  @override
  void initState() {
    super.initState();
    currentStatus = widget.currentStatus;

    // Met à jour la progression toutes les 10 secondes
    _timer = Timer.periodic(const Duration(seconds: 10), _updateProgress);
  }

  @override
  void dispose() {
    _timer.cancel(); // Annule le timer quand le widget est supprimé
    super.dispose();
  }

  // Cette méthode met à jour le statut
  void _updateProgress(Timer timer) {
    setState(() {
      int currentStep = statuses.indexWhere((s) => s == currentStatus);
      // Si le statut actuel n'est pas le dernier, passe au suivant
      if (currentStep < statuses.length - 1) {
        currentStatus = statuses[currentStep + 1];
      }
    });
  }

  int get currentStep =>
      statuses.indexWhere((s) => s == currentStatus.toLowerCase());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(statuses.length, (index) {
        final status = statuses[index];
        final isActive = index <= currentStep;
        final isLast = index == statuses.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    statusIcons[status],
                    color: isActive ? Colors.white : Colors.black38,
                    size: 22,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: isActive ? Colors.green : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                status.toUpperCase(),
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? Colors.green : Colors.black54,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
