import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileHomePage extends StatelessWidget {
  final String foodTruckId;

  const ProfileHomePage({super.key, required this.foodTruckId});

  Future<DocumentSnapshot> getFoodTruckData() async {
    return await FirebaseFirestore.instance
        .collection('foodTrucks')
        .doc(foodTruckId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getFoodTruckData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("Aucune donnée trouvée."));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final name = data['nom'] ?? '';
          final imageUrl = data['imageUrl'] ?? '';
          final description = data['description'] ?? '';
          final localisation = data['localisation'] ?? '';
          final heureOuverture = data['heureOuverture'] ?? '';
          final heureFermeture = data['heureFermeture'] ?? '';
          final email = data['email'] ?? '';
          final telephone = data['telephone'] ?? '';

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _buildProfileHeader(name, imageUrl),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildOptionButton(
                      context,
                      icon: Icons.person,
                      label: 'Profil',
                      color: const Color.fromARGB(255, 228, 159, 195),
                      route: '/profile',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildOptionButton(
                      context,
                      icon: Icons.lock,
                      label: 'Sécurité',
                      color: const Color.fromARGB(255, 228, 159, 195),
                      route: '/security',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildInfoCard(Icons.info_outline, "Description", description),
              _buildInfoCard(Icons.location_on_outlined, "Localisation", localisation),
              _buildInfoCard(Icons.access_time, "Heure d'ouverture", heureOuverture),
              _buildInfoCard(Icons.access_time_filled, "Heure de fermeture", heureFermeture),
              _buildInfoCard(Icons.email_outlined, "Email", email),
              _buildInfoCard(Icons.phone_outlined, "Téléphone", telephone),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/'),
        backgroundColor: const Color.fromARGB(255, 226, 170, 170),
        child: const Icon(Icons.home, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildProfileHeader(String name, String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey[200],
            backgroundImage: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : const AssetImage('assets/photo_profil.jpg') as ImageProvider,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Food Truck",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.pinkAccent, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text(value,
                      style: const TextStyle(
                          color: Colors.black54, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required String route,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      onPressed: () => Navigator.pushNamed(context, route),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

