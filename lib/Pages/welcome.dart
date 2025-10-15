import 'package:flutter/material.dart';
//import 'sign_in.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFFFF2B2B), // Rouge profond en bas
              Colors.white,      // Blanc vers le haut
            ],
            stops: [0.0, 0.5],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Logo sans encadrement
              Image.asset(
                'assets/images/foodifly.png',
                width: 260,
                height: 260,
              ),

              // Titre de bienvenue
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                ),
              ),

              // Citation
              Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "When hunger increases, pride decreases.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Those who are hungry have rights.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),

              // Bouton
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/SignInScreen');
                    },
                    icon: const Icon(Icons.login, size: 22),
                    label: const Text("Sign In", style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF2B2B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                  ),
                ),
              ),

              // Footer
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    const SizedBox(height: 8),
                    const Text(
                      "© 2025 Foodifly. All rights reserved.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
