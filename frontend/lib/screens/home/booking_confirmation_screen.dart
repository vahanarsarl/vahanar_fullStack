import 'package:flutter/material.dart';
import 'dart:ui';

class BookingConfirmationScreen extends StatefulWidget {
  const BookingConfirmationScreen({super.key});

  @override
  _BookingConfirmationScreenState createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: const BoxConstraints(
              minHeight: 300, // Increased height for the popup
            ),
            padding: const EdgeInsets.all(30), // Increased padding for more space
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Checkmark icon
                Container(
                  width: 80, // Increased size to match the image
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD3E0E2), // Gray background color from the image
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/valide.png',
                      width: 40, // Adjusted size of the checkmark inside the circle
                      height: 40,
                      // Removed the color property to preserve the original image colors
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Confirmation message
                const Text(
                  'Reserved successfully',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004852), // Dark teal color
                    fontFamily: 'LeagueSpartan-Bold',
                  ),
                ),
                const SizedBox(height: 12),
                // Description - First part
                const Text(
                  'Your reservation is approved, we will contact you in less than 30 minutes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey, // Gray color for the description
                    fontFamily: 'LeagueSpartan-Light',
                  ),
                ),
                const SizedBox(height: 4), // Small spacing between the two parts
                // Description - Underlined part in sky-blue
                const Text(
                  'Please stay tuned to our call',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF87CEEB), // Sky-blue color
                    fontFamily: 'LeagueSpartan-Light',
                    decoration: TextDecoration.underline, // Underline the text
                    decorationColor: Color(0xFF87CEEB), // Underline color matches the text
                  ),
                ),
                const SizedBox(height: 30),
                // Let's go button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                      // Add navigation to the next screen if needed
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004852), // Teal button color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Let’s go',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LeagueSpartan-Bold',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}