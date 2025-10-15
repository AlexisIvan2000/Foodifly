import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  String? _foodTruckId;

  // Retourne la liste des items dans le panier
  List<Map<String, dynamic>> get items => _items;

  String? _foodTruckName;

  String? get foodTruckName => _foodTruckName;

  void setFoodTruckName(String name) {
    _foodTruckName = name;
    notifyListeners();
  }

  // Retourne le nombre total d'articles dans le panier
  int get totalItems {
    return _items.fold(0, (sum, item) => sum + (item['quantity'] as int));
  }

  // Retourne le sous-total (prix des articles avant taxes)
  double get subtotal {
    return _items.fold(
        0, (sum, item) => sum + (item['prix'] * item['quantity']));
  }

  // Retourne la taxe basée sur un taux de 12%
  double get tax {
    const taxRate = 0.12;
    return subtotal * taxRate;
  }

  // Retourne le total final, incluant la taxe
  double get total {
    return subtotal + tax;
  }

  // Retourne l'ID du food truck associé à ce panier
  String? get foodTruckId => _foodTruckId;

  // Ajoute un item au panier ou incrémente sa quantité si déjà existant
void addItem(Map<String, dynamic> item) {
  if (_items.isEmpty) {
    _foodTruckId = item['foodTruckId'];
    _foodTruckName = item['foodTruckName'];
  }

  final index = _items.indexWhere((element) => element['nom'] == item['nom']);
  if (index != -1) {
    _items[index]['quantity'] += 1;
  } else {
    _items.add({
      'nom': item['nom'],
      'prix': item['prix'],
      'imageUrl': item['imageUrl'],
      'quantity': 1,
      'foodTruckId': item['foodTruckId'],
      'foodTruckName': item['foodTruckName'],
    });
  }
  notifyListeners();
}


  // Méthode pour ajouter un item au panier
  void addToCart(Map<String, dynamic> item) {
    addItem(item);
  }

  // Supprime un item du panier par son nom
  void removeItem(String nom) {
    _items.removeWhere((item) => item['nom'] == nom);
    notifyListeners();
  }

  // Incrémente la quantité d'un item
  void incrementQuantity(String nom) {
    final index = _items.indexWhere((item) => item['nom'] == nom);
    if (index != -1) {
      _items[index]['quantity'] += 1;
      notifyListeners();
    }
  }

  // Décrémente la quantité d'un item
  void decrementQuantity(String nom) {
    final index = _items.indexWhere((item) => item['nom'] == nom);
    if (index != -1 && _items[index]['quantity'] > 1) {
      _items[index]['quantity'] -= 1;
      notifyListeners();
    }
  }

  // Vide le panier
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Définir l'ID du food truck associé au panier
  void setFoodTruckId(String foodTruckId) {
    _foodTruckId = foodTruckId;
    notifyListeners();
  }

  // Vérifie si le panier est vide
  bool get isEmpty => _items.isEmpty;
}
