import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: const Center(child: Text("Welcome to the FoodiFly App!")),
    );
  }
}
