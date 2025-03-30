import 'package:flutter/material.dart';
import 'package:vahanar_front/screens/auth/sign_up/sign_up_step1.dart';
import 'package:vahanar_front/screens/auth/sign_up/sign_up_step2.dart';
import 'package:vahanar_front/screens/auth/sign_up/create_password.dart';
import 'package:vahanar_front/screens/auth/sign_up/finish_sign_up_screen.dart';
import 'package:vahanar_front/screens/auth/sign_in_screen.dart';
import 'package:vahanar_front/screens/auth/forgot_password/forgot_password.dart';
import 'package:vahanar_front/screens/auth/forgot_password/pass_email.dart';
import 'package:vahanar_front/screens/home/home_screen.dart';
import 'package:vahanar_front/screens/home/search_screen.dart';
import 'package:vahanar_front/screens/home/search_result_screen.dart';
import 'package:vahanar_front/screens/home/filter_screen.dart';
import 'package:vahanar_front/screens/profile/profile_screen.dart';
import 'package:vahanar_front/screens/help_center/help_center_screen.dart';
import 'package:vahanar_front/screens/profile/reservations_history_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        //TODO: check user logedin and redirect to home if true or greeting screen otherwaise
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/sign_up':
        return MaterialPageRoute(builder: (_) => const SignUpStep1Screen());
      case '/sign_up/step1':
        return MaterialPageRoute(builder: (_) => const SignUpStep1Screen());
      case '/sign_up/step2':
        return MaterialPageRoute(builder: (_) => const VerifyPhoneScreen());
      case '/sign_up/create_password':
        return MaterialPageRoute(builder: (_) => const CreatePasswordScreen());
      case '/sign_up/finish':
        return MaterialPageRoute(builder: (_) => const FinishSignUpScreen());
      case '/sign_in':
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case '/forgot_password/pass_email':
        return MaterialPageRoute(builder: (_) => const EmailSentScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/search/result':
        // You might want to pass arguments to the SearchResultScreen
        return MaterialPageRoute(builder: (_) => const SearchResultScreen(pickupLocation: 'Default Location', pickupDate: 'Mar 22', dropoffDate: 'Mar 24'));
      case '/search/filter':
        return MaterialPageRoute(builder: (_) => const FilterScreen(initialSortBy: 'Featured', initialVehicleType: 'SUV', initialFeature: 'Automatic transmission', initialSeats: '4', initialDriverAge: '24'));
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/help_center':
        return MaterialPageRoute(builder: (_) => const HelpCenterScreen());
      case '/my_reservations':
        return MaterialPageRoute(builder: (_) => const ReservationsHistoryScreen());
      default:
        // If there is no such route, return the error route
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('ERROR: Route not found!')),
      );
    });
  }
}