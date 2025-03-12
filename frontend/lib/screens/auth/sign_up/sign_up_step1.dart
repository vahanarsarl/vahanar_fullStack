import 'package:flutter/material.dart';
import 'package:vahanar_front/widgets/app_bar.dart';
import 'package:vahanar_front/widgets/custom_text_field.dart';
import 'package:vahanar_front/widgets/custom_button.dart';
import 'package:vahanar_front/constants.dart'; // Importation des constants

class SignUpStep1Screen extends StatefulWidget {
  const SignUpStep1Screen({super.key});

  @override
  _SignUpStep1ScreenState createState() => _SignUpStep1ScreenState();
}

class _SignUpStep1ScreenState extends State<SignUpStep1Screen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Sign Up",
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Sign up",
              style: TextStyle(
                fontSize: AppConstants.titleSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'LeagueSpartan',
                color: AppConstants.textColor,
              ),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: _nameController,
              icon: Icons.person,
              hintText: "Full name",
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _emailController,
              icon: Icons.email,
              hintText: "Email address",
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _phoneController,
              icon: Icons.phone,
              hintText: "Phone number",
            ),
            const Spacer(),
            CustomButton(
              text: "Sign Up",
              onPressed: () {
                if (_nameController.text.isEmpty ||
                    _emailController.text.isEmpty ||
                    _phoneController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill all fields"),
                    ),
                  );
                } else {
                  Navigator.pushNamed(context, '/sign_up/create_password');
                }
              },
              color: AppConstants.primaryColor,
              width: double.infinity,
              height: 50,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
