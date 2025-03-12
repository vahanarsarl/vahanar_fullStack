import 'package:flutter/material.dart';
import 'package:vahanar_front/widgets/custom_button.dart';
import 'package:vahanar_front/constants.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/grett.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40.0),
                  Text(
                    'VAHANAR',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'LeagueSpartan',
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Join Vahanar and live the way you want where you want',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: 'LeagueSpartan',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    'Earn points',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'LeagueSpartan',
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Earn Vahanar points for every valuable dollar you spend and redeem for rewards and accessories',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontFamily: 'LeagueSpartan',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(18.0)),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomButton(
                          text: 'Créer un compte',
                          onPressed: () {
                            Navigator.pushNamed(context, '/sign_up/step1');
                          },
                          color: AppConstants.primaryColor,
                        ),
                        const SizedBox(height: 10.0),
                        CustomButton(
                          text: 'Se connecter',
                          onPressed: () {
                            Navigator.pushNamed(context, '/sign_in'); // Redirection vers l'écran de connexion
                          },
                          color: Colors.black,
                        ),
                        const SizedBox(height: 10.0),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppConstants.primaryColor,
                            side: BorderSide(color: AppConstants.primaryColor),
                          ),
                          child: const Text('Rejoindre en tant qu\'invité'),
                        ),
                        const SizedBox(height: 30.0),
                        Text(
                          'want to get more informations about Us',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontFamily: 'LeagueSpartan',
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/about_us');
                          },
                          child: Text(
                            'Find more about us',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontFamily: 'LeagueSpartan',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
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
