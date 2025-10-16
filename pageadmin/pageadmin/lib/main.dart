import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'admin_login_page.dart';
import 'AppState.dart';
//import 'admin_interface.dart';
import 'profile.dart';
import 'securiter.dart';
import 'profileHomePage.dart';
//import 'food_order_page.dart';
//import 'order_history.dart';
import 'order_tracking.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.grey[100],
        primaryColor: const Color.fromARGB(255, 214, 149, 171),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 162, 216)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AdminLoginPage(),
        //'/adminInterface': (context) => const AdminInterface(),
        '/profile': (context) => const ProfilePage(),
        '/security': (context) => const SecurityPage(),
        //'/profileHomePage': (context) => const ProfileHomePage(),
        //'/food_order': (context) => FoodOrderPage(),
        //'/order_history': (context) => OrderHistory(),
        '/order_tracking': (context) => OrderTracking(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/profileHomePage') {
          final foodTruckId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ProfileHomePage(foodTruckId: foodTruckId),
          );
        }
        // Ajoute d'autres routes ici si nécessaire
        return null;
      },
    );
  }
}
