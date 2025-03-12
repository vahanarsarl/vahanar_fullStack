import 'package:flutter/material.dart';
import 'dart:async';  // Importer le Timer
import 'package:vahanar_front/screens/auth/greeting_screen.dart';  // Correct chemin pour GreetingScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Transition vers GreetingScreen après 3 secondes
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GreetingScreen()),  // Navigation vers GreetingScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004852),  // Couleur de fond
      body: Center(
        child: Image.asset('assets/images/vahanar.png'),  // Logo centré
      ),
    );
  }
}
