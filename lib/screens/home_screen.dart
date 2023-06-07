import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.green,
      title: const Text(
        "Today's Toons",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    ));
  }
}
