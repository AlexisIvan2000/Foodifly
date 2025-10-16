import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pageadmin/admin_interface.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorText;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    final id = _idController.text.trim();
    final password = _passwordController.text.trim();

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('foodTrucks')
          .doc(id)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final storedPassword = data['password'];

        if (storedPassword == password) {
          // Mot de passe correct → accès autorisé
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminInterface(foodTruckId: id),
            ),
          );
        } else {
          setState(() {
            _errorText = 'Mot de passe incorrect.';
          });
        }
      } else {
        setState(() {
          _errorText = 'Aucun FoodTruck trouvé avec cet ID.';
        });
      }
    } catch (e) {
      setState(() {
        _errorText = 'Erreur lors de la connexion : $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isMobile
            ? const Center(child: Text("Vue mobile non encore gérée"))
            : Row(
                children: [
                  // Partie gauche (texte de bienvenue)
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF2B2B),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello,\nwelcome to FoodiFly!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Connectez-vous à l'espace admin pour gérer\nvos commandes et foodtrucks.",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Partie droite (formulaire de login)
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Connectez-vous !!",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Champ ID
                          TextField(
                            controller: _idController,
                            decoration: InputDecoration(
                              labelText: 'ID du FoodTruck',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Champ mot de passe
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Erreur
                          if (_errorText != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                _errorText!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),

                          // Bouton Login
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF2B2B),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      "Login",
                                      style: TextStyle(fontSize: 16),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
