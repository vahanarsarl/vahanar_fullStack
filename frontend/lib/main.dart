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
import 'screens/auth/sign_up/finish_sign_up_screen.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/forgot_password/forgot_password.dart';
import 'screens/auth/forgot_password/pass_email.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/search_screen.dart';
import 'screens/home/search_result_screen.dart';
import 'screens/home/filter_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/help_center/help_center_screen.dart';

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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vahanar',
        theme: AppTheme.lightTheme,
        initialRoute: '/sign_up', // Changé pour tester le flux d'inscription
        routes: {
          '/': (context) => const SplashScreen(),
          '/greeting': (context) => const GreetingScreen(),
          '/sign_up': (context) => const SignUpStep1Screen(), // Ajouté pour le lien "Sign in"
          '/sign_up/step1': (context) => const SignUpStep1Screen(),
          '/sign_up/step2': (context) => const VerifyPhoneScreen(),
          '/sign_up/create_password': (context) => const CreatePasswordScreen(),
          '/sign_up/finish': (context) => const FinishSignUpScreen(),
          '/sign_in': (context) => const SignInScreen(),
          '/forgot_password': (context) => const ForgotPasswordScreen(),
          '/forgot_password/pass_email': (context) => const EmailSentScreen(),
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
          '/profile': (context) => const ProfileScreen(),
          '/driving_licence': (context) => const DrivingLicenceScreen(),
          '/help_center': (context) => const HelpCenterScreen(),
          '/my_reservations': (context) => const MyReservationsScreen(),
          '/general_conditions': (context) => const GeneralConditionsScreen(),
        },
      ),
    );
  }
}