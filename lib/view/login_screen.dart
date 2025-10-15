import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FoodiFly "),
      backgroundColor: Colors.greenAccent,
      actions: [
        IconButton(
          icon:Icon(Icons.restaurant),
          onPressed: (){
            
          },
        )
      ],),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.orange, // Background color similar to the image
          image: DecorationImage(
            image: AssetImage('images/nourriture.jpg'), // Use your background image here
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.orange.withOpacity(0.5), // Overlay effect
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150, // Adjust to match your design
                height: 150, // Adjust to match your design
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/nourriture.jpg'), // Your main image here
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome / Bienvenue ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(

                "When hunger increases, pride decreases.Those who are  hungry have rights",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.orange, backgroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text("Get Started"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

