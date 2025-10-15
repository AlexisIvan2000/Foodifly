import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _register() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();
  final confirmPassword = _confirmPasswordController.text.trim();

  if (password != confirmPassword) {
    _showError("Passwords do not match.");
    return;
  }

  try {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account created successfully!")),
    );
    Navigator.pop(context); // Retour à la page de login
  } on FirebaseAuthException catch (e) {
    debugPrint("Firebase Error: ${e.code} - ${e.message}");
    _showError(
      switch (e.code) {
        'email-already-in-use' => 'This email is already in use.',
        'weak-password' => 'Password must be at least 6 characters.',
        'invalid-email' => 'Please enter a valid email.',
        _ => e.message ?? "Registration failed."
      },
    );
  }
}


  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFFFF2B2B),
              Colors.white,
            ],
            stops: [0.0, 0.5],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration("Email", Icons.email),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: _inputDecoration("Password", Icons.lock),
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: _inputDecoration("Confirm Password", Icons.lock_outline),
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _register,
                      icon: const Icon(Icons.person_add),
                      label: const Text("Sign Up", style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF2B2B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Back to Login
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Already have an account? Sign In",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
