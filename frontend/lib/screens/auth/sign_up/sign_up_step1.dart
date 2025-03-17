import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vahanar_front/widgets/app_bar.dart';
import 'package:vahanar_front/widgets/custom_text_field.dart';
import 'package:vahanar_front/widgets/custom_button.dart';
import 'package:vahanar_front/constants.dart';
import 'package:vahanar_front/providers/auth_provider.dart';
import 'package:vahanar_front/utils/validators.dart';

class SignUpStep1Screen extends StatefulWidget {
  const SignUpStep1Screen({super.key});

  @override
  _SignUpStep1ScreenState createState() => _SignUpStep1ScreenState();
}

class _SignUpStep1ScreenState extends State<SignUpStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _navigateToNextStep() {
    if (_formKey.currentState!.validate()) {
      final userData = {
        'fullName': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
      };
      
      Navigator.pushNamed(
        context,
        '/sign_up/create_password',
        arguments: userData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Sign Up",
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                validator: (value) => Validators.validateName(value),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _emailController,
                icon: Icons.email,
                hintText: "Email address",
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validators.validateEmail(value),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _phoneController,
                icon: Icons.phone,
                hintText: "Phone number",
                keyboardType: TextInputType.phone,
                validator: (value) => Validators.validatePhoneNumber(value),
                inputFormatters: [PhoneNumberFormatter()],
              ),
              const Spacer(),
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  return CustomButton(
                    text: "Continue",
                    onPressed: authProvider.isLoading ? null : _navigateToNextStep,
                    color: AppConstants.primaryColor,
                    width: double.infinity,
                    height: 50,
                    isLoading: authProvider.isLoading,
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
