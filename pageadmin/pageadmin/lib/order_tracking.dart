import 'package:flutter/material.dart';

class OrderTracking extends StatefulWidget {
  const OrderTracking({super.key});

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  final String orderNumber = "#100045";
  final String orderDate = "30/04/2025";
  final double orderTotal = 23.96;

  List<bool> checkedSteps = [true, true, false, false]; // état des cases à cocher

  final List<String> trackingSteps = [
    "Commande reçue",
    "En préparation",
    "Prête à être récupérée",
    "Commande retirée",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suivi de la commande"),
        backgroundColor: const Color.fromARGB(255, 215, 210, 208),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Suivi de votre commande", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),

            // Info commande
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Commande : $orderNumber", style: const TextStyle(fontSize: 16)),
                    Text("Date : $orderDate", style: const TextStyle(fontSize: 16)),
                    Text("Montant : \$${orderTotal.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: ListView.separated(
                itemCount: trackingSteps.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: InkWell(
                      onTap: () {
                        setState(() {
                          checkedSteps[i] = !checkedSteps[i];
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade400, width: 2),
                          color: checkedSteps[i] ? const Color.fromARGB(255, 183, 85, 85) : Colors.white,
                        ),
                        child: checkedSteps[i]
                            ? const Icon(Icons.check, size: 18, color: Colors.white)
                            : null,
                      ),
                    ),
                    title: Text(trackingSteps[i]),
                    subtitle: checkedSteps[i] ? Text("Étape complétée", style: TextStyle(color: const Color.fromARGB(255, 190, 101, 92))) : null,
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
