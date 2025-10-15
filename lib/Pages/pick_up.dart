import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class PickupPage extends StatefulWidget {
  const PickupPage({super.key});

  @override
  _PickupPageState createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> with TickerProviderStateMixin {
  Position? _userPosition;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _userPosition = position;
    });
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> _openMap(double lat, double lon) async {
    final String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_userPosition == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final foodTrucksRef = _firestore.collection('foodTrucks');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        automaticallyImplyLeading: false,
        title: const Text(
          'Food Trucks à proximité',
          style: TextStyle(
            color: Color(0xFFFF2B2B),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: foodTrucksRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text("Aucun food truck à afficher."));
          }

          List<QueryDocumentSnapshot> nearbyTrucks = [];
          for (var doc in docs) {
            final truck = doc.data() as Map<String, dynamic>;
            final lat = truck['latitude'];
            final lon = truck['longitude'];

            if (lat != null && lon != null) {
              final distance = _calculateDistance(
                _userPosition!.latitude,
                _userPosition!.longitude,
                lat,
                lon,
              );
              if (distance <= 120) {
                nearbyTrucks.add(doc);
              }
            }
          }

          final trucksToDisplay = nearbyTrucks.isNotEmpty
              ? nearbyTrucks
              : (docs.toList()..shuffle()).take(5).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: trucksToDisplay.length,
            itemBuilder: (context, index) {
              final doc = trucksToDisplay[index];
              final truck = doc.data() as Map<String, dynamic>;
              final lat = truck['latitude'];
              final lon = truck['longitude'];
              final distance = _calculateDistance(
                _userPosition!.latitude,
                _userPosition!.longitude,
                lat,
                lon,
              );

              final AnimationController controller = AnimationController(
                duration: const Duration(milliseconds: 600),
                vsync: this,
              )..forward();

              final Animation<double> animation =
                  CurvedAnimation(parent: controller, curve: Curves.easeOut);

              return ScaleTransition(
                scale: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: InkWell(
                      onTap: () => _openMap(lat, lon),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.grey[100]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: truck['imageUrl'] != null &&
                                      truck['imageUrl'].toString().isNotEmpty
                                  ? Image.network(
                                      truck['imageUrl'],
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.store,
                                      size: 70,
                                      color: Colors.grey,
                                    ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    truck['nom'] ?? 'Nom du food truck',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFF2B2B),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.red, size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${distance.toStringAsFixed(2)} km",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    truck['description'] ??
                                        'Pas de description disponible',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF2B2B),
        onPressed: () {
          _getUserLocation();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
