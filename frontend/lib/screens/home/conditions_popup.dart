import 'package:flutter/material.dart';
import 'dart:ui'; // Pour l'effet de flou
import 'booking_confirmation_screen.dart'; // Import the second popup

class ConditionsPopup extends StatefulWidget {
  const ConditionsPopup({super.key});

  @override
  _ConditionsPopupState createState() => _ConditionsPopupState();
}

class _ConditionsPopupState extends State<ConditionsPopup> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  // Map to track the state of each checkbox
  final Map<String, bool> _conditionsState = {
    'Laisser la voiture propre après utilisation': false,
    'Respecter les règles de conduite et les limitations de vitesse': false,
    'Ne pas fumer à l’intérieur du véhicule': false,
    'Rendre la voiture avec le même niveau de carburant': false,
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Check if all conditions are accepted
  bool _areAllConditionsAccepted() {
    return _conditionsState.values.every((isChecked) => isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.only(top: 50),
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF004852), Color(0xFF007A6F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with a modern look
                const Text(
                  'Conditions de réservation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'LeagueSpartan-Bold',
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // List of conditions with checkboxes
                ..._conditionsState.keys.map((condition) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _conditionsState[condition],
                          onChanged: (bool? value) {
                            setState(() {
                              _conditionsState[condition] = value ?? false;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: const Color(0xFF004852),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                        Expanded(
                          child: Text(
                            condition,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'LeagueSpartan-Light',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
                // Button to proceed to the next popup
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _areAllConditionsAccepted()
                        ? () {
                            Navigator.of(context).pop(); // Close this popup
                            // Open the second popup
                            showDialog(
                              context: context,
                              builder: (context) => const BookingConfirmationScreen(),
                            );
                          }
                        : null, // Disable button if not all conditions are checked
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Suivant',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF004852),
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