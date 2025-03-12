import 'package:flutter/material.dart';
import 'package:vahanar_front/constants.dart'; // Importation des constants

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoggedIn = true; // Variable pour gérer l'état de la connexion
  bool isFaceIdEnabled = true; // Variable pour gérer l'état de Face ID
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordIncorrect = false; // Variable pour gérer l'état du mot de passe incorrect

  void handleLogin() {
    // Logique de vérification du mot de passe (à remplacer par votre logique réelle)
    if (_passwordController.text != "correct_password") {
      setState(() {
        isPasswordIncorrect = true;
      });
    } else {
      setState(() {
        isPasswordIncorrect = false;
      });
      // TODO: Rediriger vers la page suivante après connexion réussie
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  "VAHANAR",
                  style: TextStyle(
                    fontSize: AppConstants.titleSize,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontFamily: 'LeagueSpartan',
                    color: AppConstants.textColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "Sign in",
              style: TextStyle(
                fontSize: AppConstants.subtitleSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'LeagueSpartan',
                color: AppConstants.textColor,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            if (isPasswordIncorrect)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Incorrect password. Please try again.",
                  style: TextStyle(color: Colors.red, fontSize: 12.0),
                ),
              ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot_password'); // Redirection vers Forgot Password
                },
                child: const Text("Forgot Password?"),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Keep me logged in"),
                Switch(
                  value: isLoggedIn,
                  onChanged: (value) {
                    setState(() {
                      isLoggedIn = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Enable face ID"),
                Switch(
                  value: isFaceIdEnabled,
                  onChanged: (value) {
                    setState(() {
                      isFaceIdEnabled = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                onPressed: handleLogin, // Appel de la fonction de connexion
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: AppConstants.subtitleSize,
                    fontFamily: 'LeagueSpartan',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            const SizedBox(height: 20), // Ajout d'un espacement en bas pour une meilleure disposition
          ],
        ),
      ),
    );
  }
}
