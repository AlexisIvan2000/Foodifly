import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_provider.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

void _submitCard() async {
  if (_formKey.currentState!.validate()) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // Vérifie que le panier n’est pas vide
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

    // Calcule le nombre total d’items
    final int totalItems = cartProvider.items.fold<int>(0, (sum, item) => sum + item['quantity'] as int);

    // 1. Ajouter la commande
    final orderRef = await FirebaseFirestore.instance.collection('orders').add({
      'userId': uid,
      'foodTruckId': foodTruckId,
      'foodTruckName': foodTruckName,
      'timestamp': FieldValue.serverTimestamp(),
      'total': total,
      'status': 'reçu',
      'totalItems': totalItems,
    });

    // 2. Ajouter les items à une sous-collection "items" dans la commande
    for (var item in cartProvider.items) {
      print('Adding item: ${item['nom']}, Quantity: ${item['quantity']}');
      await orderRef.collection('items').add({
        'itemId': item['id'],
        'nom': item['nom'],
        'prix': item['prix'],
        'quantity': item['quantity'],
        'imageUrl': item['imageUrl'],
        'totalItem': item['prix'] * item['quantity'],
      });
    }

    // 3. Lancer le changement automatique du statut
    _startOrderStatusUpdate(orderRef);

    // 4. Demander si l’utilisateur souhaite enregistrer la carte
    final shouldSave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enregistrer la carte ?'),
        content: const Text('Souhaitez-vous enregistrer cette carte pour les prochaines fois ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Oui'),
          ),
        ],
      ),
    );

    // 5. Si oui, enregistrer la carte dans Firestore
    if (shouldSave == true) {
      await FirebaseFirestore.instance
          .collection('utilisateurs')
          .doc(uid)
          .collection('cartes')
          .add({
        'nom': _nameController.text.trim(),
        'numero': _numberController.text.trim(),
        'expiration': _expiryController.text.trim(),
        'cvv': _cvvController.text.trim(),
        'ajouteLe': FieldValue.serverTimestamp(),
      });
    }

    // 6. Nettoyer le panier et afficher un message
    cartProvider.clearCart();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Commande effectuée avec succès')),
    );

    Navigator.pop(context);

    print('foodTruckId: $foodTruckId, foodTruckName: $foodTruckName');
  }
}


  void _startOrderStatusUpdate(DocumentReference orderRef) async {
    const List<String> statusSequence = ['reçu', 'en préparation', 'terminée'];
    int index = 0;

    Timer.periodic(const Duration(seconds: 10), (timer) async {
      index++;
      if (index >= statusSequence.length) {
        timer.cancel(); // Stop after "terminée"
        return;
      }

      await orderRef.update({'status': statusSequence[index]});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text("Ajouter une carte"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTitle("Nom sur la carte"),
              _buildInputField(
                controller: _nameController,
                hint: "Jean Dupont",
                validatorMsg: "Veuillez entrer le nom",
              ),
              const SizedBox(height: 16),
              _buildTitle("Numéro de carte"),
              _buildInputField(
                controller: _numberController,
                hint: "1234 5678 9012 3456",
                keyboardType: TextInputType.number,
                validatorMsg: "Veuillez entrer un numéro valide",
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle("Expiration"),
                        _buildInputField(
                          controller: _expiryController,
                          hint: "MM/AA",
                          validatorMsg: "Date requise",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle("CVV"),
                        _buildInputField(
                          controller: _cvvController,
                          hint: "123",
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          validatorMsg: "CVV requis",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF2B2B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Commander",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required String validatorMsg,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? validatorMsg : null,
    );
  }
}
