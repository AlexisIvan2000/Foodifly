//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
//import 'package:page_authentification/Pages/home_page.dart';
//import 'Collections/liste_menus.dart'; // Assure-toi que ce fichier est bien dans ton projet
//import 'Collections/liste_items.dart';
//import 'Collections/liste_food_truck.dart';
import 'firebase_options.dart';
//import 'Pages/menus.dart';
//import 'Pages/home_page.dart';
import 'Pages/welcome.dart';
//import 'view/home_screen.dart';
//import 'Pages/welcome.dart';
import 'Pages/sign_in.dart'; // <-- importe ta page de sign in
import'Pages/register.dart';
import 'Pages/page_principale.dart';
import 'package:provider/provider.dart';
import 'Pages/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  // Appelle la fonction une seule fois au démarrage pour ajouter les food trucks
  //await addFoodTrucks();
  //await addItems();
  //await addMenus();


  runApp(
    DevicePreview(
      enabled: true, // passe à false pour désactiver DevicePreview
       builder: (context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
    )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  
@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Food Trucks App',
    debugShowCheckedModeBanner: false,
    locale: DevicePreview.locale(context),
    builder: DevicePreview.appBuilder,
    initialRoute: '/',
    routes: {
  '/': (context) => const WelcomeScreen(),
  '/SignInScreen': (context) => const SignInScreen(),
  '/signup': (context) => const RegisterScreen(), // <-- Doit pointer vers ta page d'inscription
  '/home': (context) => const MainNavigation(), // <-- Après connexion
},
  );
}
}

