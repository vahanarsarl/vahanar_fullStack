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
void main() {
  runApp(MyApp());
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
        '/': (context) => SplashScreen(),
        '/greeting': (context) => GreetingScreen(),
        '/sign_up/step1': (context) => SignUpStep1Screen(),
        '/sign_up/step2': (context) => VerifyPhoneScreen(),
        '/sign_up/create_password': (context) => CreatePasswordScreen(),
        '/sign_in': (context) => SignInScreen(),
        '/forgot_password': (context) => ForgotPasswordScreen(),
        '/forgot_password/pass_email': (context) => EmailSentScreen(),
        '/sign_up/finish': (context) => FinishSignUpScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
