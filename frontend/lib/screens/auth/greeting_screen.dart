import 'package:flutter/material.dart';
import 'package:vahanar_front/widgets/custom_button.dart';
import 'package:vahanar_front/constants.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: screenHeight * 0.5, // Ajuster la hauteur de l'image (50% de l'écran)
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(0.0)), // Supprimer les bords arrondis
              child: Image.asset(
                'assets/images/vahanful.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                width: screenWidth,
                height: screenHeight * 0.5,
              ),
            ),
          ),
          // Gradient Overlay (Adjusted)
          Positioned(
            top: screenHeight * 0.3, // Début du dégradé à 30% de la hauteur de l'écran
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.8], // Ajuster les stops du dégradé
                ),
              ),
            ),
          ),
          // Content (Moved to the top of the stack)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  Text(
                    'VAHANAR',
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'LeagueSpartan',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Earn points',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'LeagueSpartan',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Earn Vahanar points for every valuable dollar you spend and redeem for rewards and accessories',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: 'LeagueSpartan',
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  // Buttons
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomButton(
                          text: 'Create account',
                          onPressed: () {
                            Navigator.pushNamed(context, '/sign_up/step1');
                          },
                          color: const Color(0xFF43919D),
                          borderRadius: BorderRadius.circular(12.0),
                          textStyle: const TextStyle(
                            fontFamily: 'LeagueSpartan',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ), isLoading: null,
                        ),
                        const SizedBox(height: 16.0),
                        CustomButton(
                          text: 'Login',
                          onPressed: () {
                            Navigator.pushNamed(context, '/sign_in');
                          },
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12.0),
                          textStyle: const TextStyle(
                            fontFamily: 'LeagueSpartan',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ), isLoading: null,
                        ),
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                              fontFamily: 'LeagueSpartan',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                          child: const Text('Join as guest'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  // Information Text
                  Column(
                    children: [
                      Text(
                        'Want to get more information about us',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white.withOpacity(0.8),
                          fontFamily: 'LeagueSpartan',
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/about_us');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontFamily: 'LeagueSpartan',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        child: const Text('Find more about us'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}