import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profileHomePage.dart';
import 'menu.dart';
import 'order_history.dart';
class AdminInterface extends StatefulWidget {
  final String foodTruckId;

  const AdminInterface({super.key, required this.foodTruckId});

  @override
  State<AdminInterface> createState() => _AdminInterfaceState();
}

class _AdminInterfaceState extends State<AdminInterface>
    with SingleTickerProviderStateMixin {
  bool showMenu = false;
  late AnimationController _menuIconController;

  // Champs Firebase
  String foodtruckName = '';
  String imageUrl = '';
  String description = '';
  String localisation = '';
  String heureOuverture = '';
  String heureFermeture = '';
  String email = '';
  String telephone = '';
  String dateCreation = '';

  final String userId = 'TON_USER_ID'; // À remplacer dynamiquement si besoin

  @override
  void initState() {
    super.initState();
    _menuIconController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchFoodTruckData();
    });
  }

  Future<void> _fetchFoodTruckData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('foodTrucks')
          .doc(widget.foodTruckId)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          foodtruckName = data['nom'] ?? '';
          imageUrl = data['imageUrl'] ?? '';
          description = data['description'] ?? '';
          localisation = data['localisation'] ?? '';
          heureOuverture = data['heureOuverture'] ?? '';
          heureFermeture = data['heureFermeture'] ?? '';
          email = data['email'] ?? '';
          telephone = data['telephone'] ?? '';
          dateCreation = data['dateCreation'] ?? '';
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération du food truck : $e');
    }
  }

  @override
  void dispose() {
    _menuIconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: showMenu ? _buildMenuList() : _buildImageView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SafeArea(
                      child: ProfileHomePage(foodTruckId: widget.foodTruckId)),
                ),
              );
            },
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[300],
              backgroundImage: imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl)
                  : const AssetImage('assets/images/photo_profil.jpg')
                      as ImageProvider,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foodtruckName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                foodtruckName,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          const SizedBox(width: 12),
          AnimatedBuilder(
            animation: _menuIconController,
            builder: (_, child) {
              return Transform.rotate(
                angle: _menuIconController.value * 3.14 / 1.5,
                child: child,
              );
            },
            child: IconButton(
              icon: const Icon(Icons.menu, size: 30),
              onPressed: () {
                setState(() {
                  showMenu = !showMenu;
                  showMenu
                      ? _menuIconController.forward()
                      : _menuIconController.reverse();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList() {
    return ListView(
      key: const ValueKey('menuList'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: [
        MenuButton(
          icon: Icons.restaurant_menu,
          label: 'Food Order',
          onTap: () => Navigator.pushNamed(context, '/order_tracking'),
        ),
        MenuButton(
          icon: Icons.history,
          label: 'Order History',
          onTap: () => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => FoodOrderPage(foodTruckId: widget.foodTruckId),
  ),
),
        ),
        // MenuButton(
        //   icon: Icons.payment,
        //   label: 'Payment Details',
        //   onTap: () => Navigator.pushNamed(context, '/order_tracking'),
        // ),
        MenuButton(
          icon: Icons.restaurant,
          label: 'Gestion du Menu',
          onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => GestionMenuPage(foodTruckId: widget.foodTruckId),
    ),
  );
},

        ),
      ],
    );
  }

  Widget _buildImageView() {
    return Center(
      key: const ValueKey('menuImage'),
      child: Hero(
        tag: 'menuImage',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/foodifly.png',
            width: MediaQuery.of(context).size.width * 0.60,
            height: MediaQuery.of(context).size.height * 0.90,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  double _scale = 1.0;

  void _onTapDown(_) => setState(() => _scale = 0.97);
  void _onTapUp(_) => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 150),
      scale: _scale,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: () => setState(() => _scale = 1.0),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
            ],
          ),
          child: ListTile(
            leading: Icon(widget.icon, color: const Color(0xFFC17FA2)),
            title: Text(widget.label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }
}
