import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vahanar_front/widgets/app_bar.dart';
import 'package:vahanar_front/widgets/custom_button.dart';
import 'package:vahanar_front/constants.dart';
import 'package:vahanar_front/providers/auth_provider.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _phoneNumber;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get phone number from previous screen
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _phoneNumber = args?['phone'] ?? '';
  }

  void _verifyOtp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      
      try {
        final success = await authProvider.verifyPhoneOtp(
          phone: _phoneNumber!,
          otp: _otpController.text,
        );

        if (success) {
          Navigator.pushNamed(context, '/sign_up/finish');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  void _resendOtp(BuildContext context) async {
    try {
      await context.read<AuthProvider>().resendPhoneOtp(_phoneNumber!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New OTP sent successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Verify Phone",
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Verify your phone number",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LeagueSpartan',
                  color: AppConstants.textColor,
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "We've sent an SMS with an activation code to your phone ",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontFamily: 'LeagueSpartan'
                  ),
                  children: [
                    TextSpan(
                      text: _phoneNumber ?? '',
                      style: const TextStyle(
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              PinCodeTextField(
                appContext: context,
                length: 5,
                controller: _otpController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.length != 5) return 'Enter complete OTP';
                  return null;
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.grey.shade200,
                  selectedFillColor: Colors.white,
                  activeColor: AppConstants.primaryColor,
                  inactiveColor: Colors.grey.shade400,
                  selectedColor: AppConstants.primaryColor,
                ),
                cursorColor: AppConstants.primaryColor,
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () => _resendOtp(context),
                  child: RichText(
                    text: const TextSpan(
                      text: "I didn’t receive a code ",
                      style: TextStyle(
                        color: Colors.black45,
                        fontFamily: 'LeagueSpartan'
                      ),
                      children: [
                        TextSpan(
                          text: "Resend",
                          style: TextStyle(
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  return CustomButton(
                    text: "Verify",
                    onPressed: authProvider.isLoading ? null : () => _verifyOtp(context),
                    color: AppConstants.primaryColor,
                    width: double.infinity,
                    height: 50,
                    isLoading: authProvider.isLoading,
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}