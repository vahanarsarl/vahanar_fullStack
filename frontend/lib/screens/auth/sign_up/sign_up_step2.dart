import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:vahanar_front/providers/auth_provider.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _handleVerify(String phoneNumber) async {
    if (_otpController.text.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid OTP")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.verifyPhone(_otpController.text);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.pushReplacementNamed(context, '/profile');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.error ?? 'Failed to verify phone number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer le numéro de téléphone passé depuis CreatePasswordScreen
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final phoneNumber = arguments['phoneNumber'] as String;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header personnalisé
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Titre "Verify your phone number"
              const Text(
                'Verify your phone number',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'LeagueSpartan-Bold',
                ),
              ),
              const SizedBox(height: 10),
              // Texte descriptif
              RichText(
                text: TextSpan(
                  text: "We've sent an SMS with an activation code to your phone ",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontFamily: 'LeagueSpartan-Light',
                  ),
                  children: [
                    TextSpan(
                      text: phoneNumber,
                      style: const TextStyle(
                        color: Color(0xFF2A4D50),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LeagueSpartan-Light',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Champs OTP
              PinCodeTextField(
                appContext: context,
                length: 5,
                controller: _otpController,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: Colors.grey,
                  inactiveColor: Colors.grey,
                  selectedColor: const Color(0xFF2A4D50),
                ),
                cursorColor: const Color(0xFF2A4D50),
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),
              // Texte "I didn’t receive a code Resend"
              Center(
                child: RichText(
                  text: const TextSpan(
                    text: "I didn’t receive a code ",
                    style: TextStyle(
                      color: Colors.black45,
                      fontFamily: 'LeagueSpartan-Light',
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: "Resend",
                        style: TextStyle(
                          color: Color(0xFF2A4D50),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LeagueSpartan-Light',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // Bouton "Verify"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => _handleVerify(phoneNumber),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A4D50),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'LeagueSpartan-Bold',
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