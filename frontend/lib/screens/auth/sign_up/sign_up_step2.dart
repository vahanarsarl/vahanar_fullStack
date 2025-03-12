import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vahanar_front/widgets/app_bar.dart';
import 'package:vahanar_front/widgets/custom_button.dart';
import 'package:vahanar_front/constants.dart'; // Importation des constants

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Verify Phone",
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              text: const TextSpan(
                text: "We've sent an SMS with an activation code to your phone ",
                style: TextStyle(color: Colors.black54, fontSize: 16, fontFamily: 'LeagueSpartan'),
                children: [
                  TextSpan(
                    text: "+212 6 14 74 61 98",
                    style: TextStyle(
                      color: AppConstants.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LeagueSpartan',
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
              child: RichText(
                text: const TextSpan(
                  text: "I didn’t receive a code ",
                  style: TextStyle(color: Colors.black45, fontFamily: 'LeagueSpartan'),
                  children: [
                    TextSpan(
                      text: "Resend",
                      style: TextStyle(
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LeagueSpartan',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              text: "Verify",
              onPressed: () {
                if (_otpController.text.length == 5) {
                  Navigator.pushNamed(context, '/sign_up/finish'); // Redirection vers FinishSignUpScreen
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter a valid OTP"),
                    ),
                  );
                }
              },
              color: AppConstants.primaryColor,
              width: double.infinity,
              height: 50,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
