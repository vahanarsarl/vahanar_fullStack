import 'package:flutter/material.dart';
import 'package:vahanar_front/constants.dart'; // Importation des constants

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool isInvalidEmail = false; // Variable pour gérer l'état de l'email invalide

  void handleSendEmail() {
    String email = _emailController.text.trim();

    // Vérification que l'email contient le symbole @
    if (!email.contains('@')) {
      setState(() {
        isInvalidEmail = true;
      });
      return;
    }

    // Si l'email est valide, redirige vers la page PassEmailScreen
    setState(() {
      isInvalidEmail = false;
    });
    Navigator.pushNamed(context, '/forgot_password/pass_email'); // Correction de la route
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: AppConstants.titleSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'LeagueSpartan',
                color: AppConstants.textColor,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Please enter your email address",
              style: TextStyle(
                fontSize: AppConstants.bodyTextSize,
                fontFamily: 'LeagueSpartan',
                color: AppConstants.textColor,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              autofillHints: [AutofillHints.email],
            ),
            if (isInvalidEmail)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Please enter a valid email address.",
                  style: TextStyle(color: Colors.red, fontSize: 12.0),
                ),
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
                onPressed: handleSendEmail,
                child: Text(
                  "Send email",
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
