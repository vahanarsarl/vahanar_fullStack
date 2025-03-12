import 'package:flutter/material.dart';
import 'package:vahanar_front/constants.dart'; // Importation des constants

class FinishSignUpScreen extends StatelessWidget {
  const FinishSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/valide.png', height: 100),
              const SizedBox(height: 30),
              const Text(
                "Successful",
                style: TextStyle(
                  fontSize: AppConstants.titleSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LeagueSpartan',
                  color: AppConstants.primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Your account has been created successfully.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppConstants.bodyTextSize,
                  fontFamily: 'LeagueSpartan',
                  color: Color(0xFF989898), // Couleur HEX 989898
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: AppConstants.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home'); // Redirection vers la page Home
                  },
                  child: Text(
                    "Let's go",
                    style: TextStyle(
                      fontSize: AppConstants.subtitleSize,
                      fontFamily: 'LeagueSpartan',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
