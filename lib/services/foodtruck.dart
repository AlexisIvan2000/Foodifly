class Foodtrucks {
  final String id;
  final String name;
  final String description;
  final String localisation;
  final String heureOuverture;
  final String heureFermeture;
  final String email;
  final String imageUrl;
  final bool isFreeDelivery;

  Foodtrucks({
    required this.id,
    required this.name,
    required this.description,
    required this.localisation,
    required this.heureOuverture,
    required this.heureFermeture,
    required this.email,
    required this.imageUrl,
    required this.isFreeDelivery,
  });
}