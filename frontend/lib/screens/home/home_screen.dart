import 'package:flutter/material.dart';
import 'package:vahanar_front/widgets/bottom_nav_bar.dart'; // Importation de la barre de navigation inférieure
import 'package:vahanar_front/constants.dart'; // Importation des constants

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Pour éviter le bouton de retour par défaut
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // TODO: Ajouter la logique de notification
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "WELCOME",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'LeagueSpartan',
                color: AppConstants.textColor,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Plan Your Next Trip",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'LeagueSpartan',
                color: AppConstants.textColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Make a reservation",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Ajouter la logique de réservation
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(14),
                    backgroundColor: AppConstants.primaryColor,
                  ),
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Recent Searches",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'LeagueSpartan',
                color: AppConstants.textColor,
              ),
            ),
            const SizedBox(height: 10),
            buildRecentSearchCard(),
            buildRecentSearchCard(),
            const SizedBox(height: 30),
            const Text(
              "VAHANAR",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'LeagueSpartan',
                color: AppConstants.textColor,
              ),
            ),
            const SizedBox(height: 10),
            buildVahanarSection(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Need Help?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'LeagueSpartan',
                    color: AppConstants.textColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    // TODO: Ajouter la logique de besoin d'aide
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(), // Ajout de la barre de navigation inférieure
    );
  }

  Widget buildRecentSearchCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Mohamed V Intl Airport, casab... Mar 25 - Mar 27",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'LeagueSpartan',
                color: AppConstants.textColor,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Ajouter la logique de réservation continue
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor, // Mise à jour de la ligne 151
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Continue Reserving",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'LeagueSpartan',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVahanarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/credit_card.png', height: 100),
        const SizedBox(height: 20),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Earn points",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'LeagueSpartan',
                    color: AppConstants.textColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Earn vahanar points for every valuable dollar you spend and redeem for rewards and accessories.",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'LeagueSpartan',
                    color: AppConstants.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Earn points",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'LeagueSpartan',
                    color: AppConstants.textColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Earn vahanar points for every valuable dollar you spend and redeem for rewards and accessories.",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'LeagueSpartan',
                    color: AppConstants.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
