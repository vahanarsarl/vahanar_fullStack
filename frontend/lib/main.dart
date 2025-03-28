import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Theme import
import 'theme.dart';

// Provider imports
import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'providers/booking_provider.dart';
// Screen imports
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
import 'screens/home/filter_screen.dart';
import 'screens/profile/profile_screen.dart'; // Importer ProfileScreen

// Placeholders pour les pages manquantes
class DrivingLicenceScreen extends StatelessWidget {
  const DrivingLicenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Driving Licence Screen')),
    );
  }
}

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Help Center Screen')),
    );
  }
}

class MyReservationsScreen extends StatelessWidget {
  const MyReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('My Reservations Screen')),
    );
  }
}

class GeneralConditionsScreen extends StatelessWidget {
  const GeneralConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('General Conditions Screen')),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
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
          '/profile': (context) => const ProfileScreen(), // Route pour ProfileScreen
          '/driving_licence': (context) => const DrivingLicenceScreen(), // Route pour Driving Licence
          '/help_center': (context) => const HelpCenterScreen(), // Route pour Help Center
          '/my_reservations': (context) => const MyReservationsScreen(), // Route pour My Reservations
          '/general_conditions': (context) => const GeneralConditionsScreen(), // Route pour General Conditions
        },
      ),
    );
  }
}