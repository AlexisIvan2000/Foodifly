import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppState extends ChangeNotifier {
  // --- Données utilisateur ---
  String _userId = '';
  String _foodtruckName = '';
  String _imageUrl = '';
  bool _isAdmin = false;
  String _profileImage = '';

  // --- Infos Food Truck ---
  String _description = '';
  String _localisation = '';
  String _heureOuverture = '';
  String _heureFermeture = '';
  String _email = '';
  String _telephone = '';
  String _dateCreation = '';

  // --- Thème ---
  bool _isDarkMode = false;

  // --- Favoris ---
  final Set<String> _favoriteFoodTrucks = {};

  // --- Panier ---
  final Map<String, List<Map<String, dynamic>>> _cartItems = {};

  // --- Getters ---
  String get userId => _userId;
  String get foodtruckName => _foodtruckName;
  String get imageUrl => _imageUrl;
  bool get isAdmin => _isAdmin;
  String get profileImage => _profileImage;

  String get description => _description;
  String get localisation => _localisation;
  String get heureOuverture => _heureOuverture;
  String get heureFermeture => _heureFermeture;
  String get email => _email;
  String get telephone => _telephone;
  String get dateCreation => _dateCreation;

  bool get isDarkMode => _isDarkMode;
  Set<String> get favoriteFoodTrucks => _favoriteFoodTrucks;
  Map<String, List<Map<String, dynamic>>> get cartItems => _cartItems;

  // --- Setters / Mutateurs ---
  void setUserId(String id) {
    _userId = id;
    notifyListeners();
  }

  void setFoodTruck(String name, String imageUrl) {
    _foodtruckName = name;
    _imageUrl = imageUrl;
    notifyListeners();
  }

  void setFoodTruckDetails({
    required String description,
    required String localisation,
    required String heureOuverture,
    required String heureFermeture,
    required String email,
    required String telephone,
    required String dateCreation,
  }) {
    _description = description;
    _localisation = localisation;
    _heureOuverture = heureOuverture;
    _heureFermeture = heureFermeture;
    _email = email;
    _telephone = telephone;
    _dateCreation = dateCreation;
    notifyListeners();
  }

  void setIsAdmin(bool value) {
    _isAdmin = value;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // --- Méthodes de mise à jour individuelles ---
  void updateProfileImage(String url) {
    _profileImage = url;
    notifyListeners();
  }

  void updateFoodtruckName(String name) {
    _foodtruckName = name;
    notifyListeners();
  }

  void updateDescription(String desc) {
    _description = desc;
    notifyListeners();
  }

  void updateFoodtruckEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void updateFoodtruckPhoneNumber(String phone) {
    _telephone = phone;
    notifyListeners();
  }

  void updateFoodtruckAddress(String address) {
    _localisation = address;
    notifyListeners();
  }

  void updateOpeningHours(String opening) {
    _heureOuverture = opening;
    notifyListeners();
  }

  void updateClosingHours(String closing) {
    _heureFermeture = closing;
    notifyListeners();
  }

  void updateDateCreation(String date) {
    _dateCreation = date;
    notifyListeners();
  }

  // --- Favoris ---
  void toggleFavorite(String foodTruckId) {
    if (_favoriteFoodTrucks.contains(foodTruckId)) {
      _favoriteFoodTrucks.remove(foodTruckId);
    } else {
      _favoriteFoodTrucks.add(foodTruckId);
    }
    notifyListeners();
  }

  bool isFavorite(String foodTruckId) {
    return _favoriteFoodTrucks.contains(foodTruckId);
  }

  // --- Panier ---
  void addToCart(String foodTruckId, Map<String, dynamic> item) {
    _cartItems.putIfAbsent(foodTruckId, () => []);
    _cartItems[foodTruckId]!.add(item);
    notifyListeners();
  }

  void removeFromCart(String foodTruckId, int index) {
    if (_cartItems.containsKey(foodTruckId) &&
        index >= 0 &&
        index < _cartItems[foodTruckId]!.length) {
      _cartItems[foodTruckId]!.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart(String foodTruckId) {
    _cartItems[foodTruckId]?.clear();
    notifyListeners();
  }

  int getTotalItemCount(String foodTruckId) {
    return _cartItems[foodTruckId]?.length ?? 0;
  }

  double getTotalPrice(String foodTruckId) {
    if (!_cartItems.containsKey(foodTruckId)) return 0;
    return _cartItems[foodTruckId]!
        .fold(0.0, (total, item) => total + (item['price'] ?? 0.0));
  }

  // --- Réinitialisation ---
  void reset() {
    _userId = '';
    _foodtruckName = '';
    _imageUrl = '';
    _isAdmin = false;
    _profileImage = '';

    _description = '';
    _localisation = '';
    _heureOuverture = '';
    _heureFermeture = '';
    _email = '';
    _telephone = '';
    _dateCreation = '';

    _favoriteFoodTrucks.clear();
    _cartItems.clear();
    notifyListeners();
  }
}
