import 'package:flutter/material.dart';
import 'home_page.dart';
import 'favoris.dart';
import 'orders_page.dart'; // 🆕 Commandes
import 'pick_up.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const FavoritesPage(),
    const OrderPage(),     // 🆕 Ajout des commandes
    const PickupPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFFFF2B2B),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoris'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Commandes'),
            BottomNavigationBarItem(icon: Icon(Icons.directions_walk), label: 'PickUp'),
          ],
        ),
      ),
    );
  }
}

