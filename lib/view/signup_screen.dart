import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
          image: DecorationImage(
            image: AssetImage('images/nourriture.jpg'), 
            fit: BoxFit.cover, 
          ),
        ),
        child: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Log in !",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), // Couleur du texte
              ),
             const SizedBox(height: 40),ElevatedButton(

                onPressed: () {

                  Navigator.pushNamed(context, '/admin');

                },
                child: const Text("Administrator"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/customer');

                },
                child: const Text("Customer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}