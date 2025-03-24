import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/greeting_screen.dart';
import 'screens/auth/sign_up/sign_up_step1.dart';
import 'screens/auth/sign_up/sign_up_step2.dart';
import 'screens/auth/sign_up/create_password.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/forgot_password/forgot_password.dart';
import 'screens/auth/forgot_password/pass_email.dart';
import 'screens/auth/sign_up/finish_sign_up_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/search_screen.dart';
import 'screens/home/search_result_screen.dart';
import 'screens/home/filter_screen.dart'; // Réimporter FilterScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vahanar',
      theme: AppTheme.lightTheme, // Utilisation du thème
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/greeting': (context) => const GreetingScreen(),
        '/sign_up/step1': (context) => const SignUpStep1Screen(),
        '/sign_up/step2': (context) => const VerifyPhoneScreen(),
        '/sign_up/create_password': (context) => const CreatePasswordScreen(),
        '/sign_in': (context) => const SignInScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/forgot_password/pass_email': (context) => const EmailSentScreen(),
        '/sign_up/finish': (context) => const FinishSignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
        '/search/result': (context) => const SearchResultScreen(
              pickupLocation: 'Default Location',
              pickupDate: 'Mar 22',
              dropoffDate: 'Mar 24',
            ),
        '/search/filter': (context) => const FilterScreen(
              initialSortBy: 'Featured',
              initialVehicleType: 'SUV',
              initialFeature: 'Automatic transmission',
              initialSeats: '4',
              initialDriverAge: '24',
            ),
      },
    );
  }
}