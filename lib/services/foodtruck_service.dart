import 'package:cloud_firestore/cloud_firestore.dart';
import 'foodtruck.dart';

Future<List<Foodtrucks>> fetchFoodtrucks() async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection('foodTrucks').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return Foodtrucks(
        id: doc.id,
        name: data['nom'] ?? '',
        description: data['description'] ?? '',
        localisation: data['localisation'] ?? '',
        heureOuverture: data['heureOuverture'] ?? '',
        heureFermeture: data['heureFermeture'] ?? '',
        email: data['email'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        isFreeDelivery: data['isFreeDelivery'] ?? false,
      );
    }).toList();
  } catch (e) {
    print('Erreur lors du chargement des food trucks: $e');
    return [];
  }
}