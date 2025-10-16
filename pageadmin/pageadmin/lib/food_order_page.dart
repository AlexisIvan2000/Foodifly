import 'package:flutter/material.dart';

class FoodOrderPage extends StatelessWidget {
  // Fonction pour construire une carte de commande
  Widget _buildCard(String title, int quantity, String status, double price, int index) {
    // Fonction pour définir la couleur du statut
    Color _statusColor(String status) {
      switch (status) {
        case 'In Progress':
          return Colors.orange.shade300;
        case 'Out for Delivery':
          return Colors.amber.shade600;
        case 'Delivered':
          return Colors.green.shade400;
        default:
          return Colors.grey;
      }
    }

    // Fonction pour définir l'icône du statut
    IconData _statusIcon(String status) {
      switch (status) {
        case 'In Progress':
          return Icons.timelapse;
        case 'Out for Delivery':
          return Icons.delivery_dining;
        case 'Delivered':
          return Icons.check_circle;
        default:
          return Icons.help;
      }
    }

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + index * 100),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre de la pizza
              Text("🍕 $title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantité de la commande
                  Text("Quantity: $quantity", style: TextStyle(fontSize: 14)),
                  
                  // Animation de l'icône et du statut
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                    child: Row(
                      key: ValueKey(status),
                      children: [
                        // Icône du statut avec animation de couleur
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _statusColor(status).withOpacity(0.2), // couleur d'arrière-plan du statut
                          ),
                          child: Icon(
                            _statusIcon(status),
                            color: _statusColor(status),
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 6),
                        
                        // Texte du statut
                        Text(status, style: TextStyle(fontSize: 14, color: _statusColor(status))),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              // Montant de la commande
              Text("💵 \$${price.toStringAsFixed(2)}", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Order Page"),
        backgroundColor: const Color.fromARGB(255, 209, 61, 61),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retour avec l'animation par défaut
          },
        ),
      ),
      body: ListView(
        children: [
          _buildCard("Four cheese Pizza", 1, "In Progress", 18.99, 0),
          _buildCard("Garlic Bread", 2, "In Progress", 9.98, 1),
          _buildCard("Caesar Salad", 1, "Out for Delivery", 10.50, 2),
          _buildCard("Margherita Pizza", 1, "Delivered", 16.50, 3),
        ],
      ),
    );
  }
}
