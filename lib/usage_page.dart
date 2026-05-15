import 'package:flutter/material.dart';

class UsagePage extends StatelessWidget {
  const UsagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Su Kullanımı"),
        backgroundColor: Colors.blue,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          kullanimKarti(
            "Mutfak",
            "120 L",
            Icons.kitchen,
            Colors.orange,
          ),

          kullanimKarti(
            "Banyo",
            "80 L",
            Icons.bathtub,
            Colors.blue,
          ),

          kullanimKarti(
            "Tuvalet",
            "45 L",
            Icons.wc,
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget kullanimKarti(
      String alan,
      String litre,
      IconData icon,
      Color renk,
      ) {

    return Card(
      margin: const EdgeInsets.only(bottom: 20),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: renk,
          child: Icon(icon, color: Colors.white),
        ),

        title: Text(alan),

        subtitle: const Text("Günlük kullanım"),

        trailing: Text(
          litre,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}